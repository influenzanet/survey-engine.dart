import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';

class ExpressionEvaluation {
// Should be changed to ReturnType function instead of bool

  dynamic evalExpression(Expression expression) {
    var checkValidMap;
    var exprMap = expression.toMap();
    try {
      checkValidMap = expressionArguments
          .firstWhere((iter) => iter['name'] == exprMap['name']);
    } catch (e) {
      throw InvalidArgumentsException();
    }
    if ((checkValidMap['arguments'] > expression.data.length)) {
      throw ArgumentCountException();
    }
    switch (expression.name) {
      case 'lt':
        return lt(expression);
        break;
      case 'lte':
        return lte(expression);
        break;
      case 'gt':
        return gt(expression);
        break;
      case 'gte':
        return gte(expression);
        break;
      case 'eq':
        return eq(expression);
        break;
      case 'or':
        return or(expression);
        break;
      case 'and':
        return and(expression);
        break;
      case 'not':
        return not(expression);
        break;
    }
    return false;
  }

  dynamic getData(ExpressionArg arg) {
    switch (arg.dType.dType) {
      case 'number':
        return arg.number;
        break;
      case 'str':
        return arg.str;
      case 'exp':
        return arg.exp;
    }
  }

  List<dynamic> evaluateBinaryOperands(ExpressionArg arg1, ExpressionArg arg2) {
    var argument1 = getData(arg1);
    var argument2 = getData(arg2);

    var res1 = arg1.exp != null ? evalExpression(argument1) : argument1;
    var res2 = arg2.exp != null ? evalExpression(argument2) : argument2;
    return [res1, res2];
  }

// Relational operations
  bool lt(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var result = evaluateBinaryOperands(arguments[0], arguments[1]);
    return result[0] is String
        ? (result[0].compareTo(result[1]) == -1)
        : result[0] < result[1];
  }

  bool gt(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var result = evaluateBinaryOperands(arguments[0], arguments[1]);
    return result[0] is String
        ? (result[0].compareTo(result[1]) == 1)
        : result[0] > result[1];
  }

  bool eq(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var identicalCheckArg = arguments[0];
    return arguments.every((arg) => arg == identicalCheckArg);
  }

  bool gte(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var result = evaluateBinaryOperands(arguments[0], arguments[1]);
    return result[0] is String
        ? (result[0].compareTo(result[1]) >= 0)
        : result[0] >= result[1];
  }

  bool lte(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var result = evaluateBinaryOperands(arguments[0], arguments[1]);
    return result[0] is String
        ? (result[0].compareTo(result[1]) <= 0)
        : result[0] <= result[1];
  }

// Logical operations
  bool getLogicalEvaluation(ExpressionArg arg) {
    switch (arg.dType.dType) {
      case 'number':
        return (arg.number > 0);
        break;
      case 'str':
        return (arg.str.length > 0);
        break;
      case 'exp':
        return (evalExpression(arg.exp));
        break;
      default:
        return false;
    }
  }

  bool or(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    bool result = false;
    for (final arg in arguments) {
      result = getLogicalEvaluation(arg);
      if (result == true) {
        break;
      }
    }
    return result;
  }

  bool and(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    bool result = true;
    for (final arg in arguments) {
      result = getLogicalEvaluation(arg);
      if (result == false) {
        break;
      }
    }
    return result;
  }

  bool not(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    if (arguments.length > 1) {
      throw ArgumentCountException();
    }
    return !getLogicalEvaluation(arguments[0]);
  }
}

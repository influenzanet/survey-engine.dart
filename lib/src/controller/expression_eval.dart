import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';

class ExpressionEvaluation {
// Should be changed to ReturnType function instead of bool

  bool evalExpression(Expression expression) {
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
    }
    return false;
  }

// Relational operations
  bool lt(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    switch (arguments[0].dType.dType) {
      case 'number':
        return arguments[0].number < arguments[1].number;
        break;

      case 'str':
        return (arguments[0].str.compareTo(arguments[1].str)) == -1;
        break;
    }
    return false;
  }

  bool gt(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    switch (arguments[0].dType.dType) {
      case 'number':
        return arguments[0].number > arguments[1].number;
        break;

      case 'str':
        return (arguments[0].str.compareTo(arguments[1].str)) == 1;
        break;
    }
    return false;
  }

  bool eq(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var identicalCheckArg = arguments[0];
    return arguments.every((arg) => arg == identicalCheckArg);
  }

  bool gte(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    switch (arguments[0].dType.dType) {
      case 'number':
        return arguments[0].number >= arguments[1].number;
        break;

      case 'str':
        return (arguments[0].str.compareTo(arguments[1].str)) >= 0;
        break;
    }
    return false;
  }

  bool lte(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    switch (arguments[0].dType.dType) {
      case 'number':
        return arguments[0].number <= arguments[1].number;
        break;
      case 'str':
        return (arguments[0].str.compareTo(arguments[1].str)) <= 0;
        break;
    }
    return false;
  }

// Logical operations
  bool or(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    switch (arguments[0].dType.dType) {
      case 'number':
        var trueData =
            arguments.firstWhere((arg) => arg.number > 0, orElse: () => null);
        return trueData == null ? false : true;
        break;
      case 'str':
        var trueData = arguments.firstWhere((arg) => arg.str.length > 0,
            orElse: () => null);
        return trueData == null ? false : true;
        break;
      //Need to check
      case 'exp':
        return evalExpression(arguments[0].exp);
    }
    return false;
  }

  bool and(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    switch (arguments[0].dType.dType) {
      case 'number':
        return arguments.every((arg) => arg.number > 0);
        break;
      case 'str':
        return arguments.every((arg) => arg.str.length > 0);
        break;
      //Need to check
      case 'exp':
        return evalExpression(arguments[0].exp);
    }
    return false;
  }
}

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';

class ExpressionEvaluation {
  Expression expr;

  ExpressionEvaluation({
    this.expr,
  });

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
    if ((checkValidMap['arguments'] > this.expr.data.length)) {
      throw ArgumentCountException();
    }
    switch (expression.name) {
      // logical operators -->
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
    }
    return false;
  }

// Logical operations
  bool lt(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    switch (arguments[0].dType.dType) {
      case 'number':
        return arguments[0].number < arguments[1].number;
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
      case 'str':
        return (arguments[0].str.compareTo(arguments[1].str)) == 1;
        break;
    }
    return false;
  }

  bool eq(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    return arguments[0] == arguments[1];
  }

  bool gte(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    switch (arguments[0].dType.dType) {
      case 'number':
        return arguments[0].number >= arguments[1].number;
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
      case 'str':
        return (arguments[0].str.compareTo(arguments[1].str)) <= 0;
        break;
    }
    return false;
  }
}

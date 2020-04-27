import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_context.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_single_item.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_group_item_response.dart';

class ExpressionEvaluation {
  SurveyContext context;
  dynamic renderedSurvey;
  SurveyGroupItemResponse responses;
  SurveySingleItem temporaryItem;
  ExpressionEvaluation(
      {this.context, this.renderedSurvey, this.responses, this.temporaryItem});
  dynamic evalExpression(
      {Expression expression, SurveyContext context, List<dynamic> items}) {
    var checkValidMap;
    var exprMap = expression.toMap();
    try {
      checkValidMap = expressionArguments
          .firstWhere((iter) => iter['name'] == exprMap['name']);
    } catch (e) {
      throw InvalidArgumentsException();
    }
    if (expression.data != null &&
        (!rootReferenceExpressions.contains(checkValidMap['name'])) &&
        (checkValidMap['arguments'] > expression.data.length)) {
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
      case 'isDefined':
        return isDefined(expression);
        break;
      case 'getContext':
        return getContext();
        break;
      case 'getResponses':
        return getResponses();
        break;
      case 'getRenderedItems':
        return getRenderedItems();
        break;
      case 'getAttribute':
        return getAttribute(expression);
        break;
      case 'getArrayItemAtIndex':
        return getArrayItemAtIndex(expression);
        break;
      // Needs to change after returnType of Expression is confirmed
      case 'sequential':
        return items;
        break;
      case 'random':
        return random(items);
        break;
    }
    return false;
  }

  dynamic getData(ExpressionArg arg) {
    switch (arg.exprArgDType.dtype) {
      case 'num':
        return arg.number;
        break;
      case 'str':
        return arg.str;
      case 'exp':
        return arg.exp;
    }
  }

  dynamic evaluateArgument(ExpressionArg arg) {
    if (arg == null) {
      return null;
    }
    var argument = getData(arg);
    var result =
        arg.exp != null ? evalExpression(expression: argument) : argument;
    return result;
  }

  List<dynamic> evaluateBinaryOperands(ExpressionArg arg1, ExpressionArg arg2) {
    var res1 = evaluateArgument(arg1);
    var res2 = evaluateArgument(arg2);
    return [res1, res2];
  }

// Relational operations
  bool lt(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var result = evaluateBinaryOperands(
        arguments[firstArgument], arguments[secondArgument]);
    return result[firstExpression] is String
        ? (result[firstExpression].compareTo(result[secondExpression]) <
            stringEqualityValue)
        : result[firstExpression] < result[secondExpression];
  }

  bool gt(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var result = evaluateBinaryOperands(
        arguments[firstArgument], arguments[secondArgument]);
    return result[firstExpression] is String
        ? (result[firstExpression].compareTo(result[secondExpression]) >
            stringEqualityValue)
        : result[firstExpression] > result[secondExpression];
  }

  bool eq(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var identicalCheckArg = arguments[firstArgument];
    return arguments.every((arg) => arg == identicalCheckArg);
  }

  bool gte(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var result = evaluateBinaryOperands(
        arguments[firstArgument], arguments[secondArgument]);
    return result[firstExpression] is String
        ? (result[firstExpression].compareTo(result[secondExpression]) >=
            stringEqualityValue)
        : result[firstExpression] >= result[secondExpression];
  }

  bool lte(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var result = evaluateBinaryOperands(
        arguments[firstArgument], arguments[secondArgument]);
    return result[firstExpression] is String
        ? (result[firstExpression].compareTo(result[secondExpression]) <=
            stringEqualityValue)
        : result[firstExpression] <= result[secondExpression];
  }

// Logical operations
  bool getLogicalEvaluation(ExpressionArg arg) {
    switch (arg.exprArgDType.dtype) {
      case 'num':
        return (arg.number > 0);
        break;
      case 'str':
        return (arg.str.length > 0);
        break;
      case 'exp':
        return (evalExpression(expression: arg.exp));
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
      // `or` evaluates to true even if single expression returns true
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
      // `and` evaluates to false even if single expression returns false
      if (result == false) {
        break;
      }
    }
    return result;
  }

  bool not(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    if (arguments.length > maxUnaryOperands) {
      throw ArgumentCountException();
    }
    return !getLogicalEvaluation(arguments[firstArgument]);
  }

  bool isDefined(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    if (arguments.length > maxUnaryOperands) {
      throw ArgumentCountException();
    }
    var argument = getData(arguments[firstArgument]);
    var result = arguments[firstArgument].exp != null
        ? evalExpression(expression: argument)
        : argument;
    return (result != null);
  }

  List<dynamic> random(dynamic items) {
    // TO DO this and random seed needs to be implemented in typescript and is subject to change
    items.shuffle;
    return items;
  }

// Root references
  SurveyContext getContext() {
    return this.context;
  }

  SurveyGroupItemResponse getResponses() {
    return this.responses;
  }

  dynamic getRenderedItems() {
    return this.renderedSurvey;
  }

  // Object and arrays

  dynamic getAttribute(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    if (arguments[secondArgument].str == null) {
      throw InvalidArgumentsException(
          message: 'getAttribute expected second argument to be a string');
    }

    var reference = getData(arguments[firstArgument]);
    var root;
    if (!(reference is Expression)) {
      if (this.temporaryItem == null) {
        throw InvalidArgumentsException(
            message:
                'getAttribute expected first argument is not a valid expression or temporary object to be set');
      }
      if (reference == 'this') {
        root = this.temporaryItem;
      }
    } else {
      root = evalExpression(expression: reference);
    }
    if (root == null) {
      throw InvalidArgumentsException(
          message:
              'getAttribute expected first argument received wrong type of reference object');
    }
    try {
      if (!(root is Map)) {
        root = root?.toMap();
      }
    } catch (e) {
      throw InvalidArgumentsException(
          message:
              'getAttribute expected first argument received wrong type of reference object');
    }
    var attribute = root[expression.data[secondArgument].str];
    if (expression.returnType != null) {
      attribute = Utils.parseExpressionReturnType(
          item: attribute, returnType: expression.returnType);
    }
    return attribute;
  }

  dynamic getArrayItemAtIndex(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var arg1 = getData(arguments[firstArgument]);
    var arg2 = getData(arguments[secondArgument]);

    if (arg1 == null || !(arg1 is Expression)) {
      throw InvalidArgumentsException(
          message: 'getArrayItem: First argument needs to be an expression');
    }
    if (!(arg2 is num)) {
      throw InvalidArgumentsException(
          message: 'getArrayItem: Second argument needs to be a number');
    }

    var array = evalExpression(expression: arg1);
    if (!(array is List) || (array is List && array.length <= arg2)) {
      throw InvalidArgumentsException(
          message:
              'getArrayItem: First argument Expression on evaluation needs to return a list');
    }

    var item = array[arg2];
    if (expression.returnType != null) {
      item = Utils.parseExpressionReturnType(
          item: item, returnType: expression.returnType);
    }
    return item;
  }
}

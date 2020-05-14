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
      {Expression expression,
      SurveyContext context,
      dynamic renderedSurvey,
      SurveyGroupItemResponse responses,
      SurveySingleItem temporaryItem,
      List<dynamic> items}) {
    this.context = context ?? this.context;
    this.renderedSurvey = renderedSurvey ?? this.renderedSurvey;
    this.responses = responses ?? this.responses;
    this.temporaryItem = temporaryItem ?? this.temporaryItem;
    var checkValidMap;
    var exprMap = expression.toMap();

    checkValidMap = expressionArguments.firstWhere(
        (iter) => iter['name'] == exprMap['name'],
        orElse: () => null);

    if (checkValidMap == null) {
      Warning(
          message: exprMap['name'] +
              ': is not a valid expression name or is not implemented');
      return false;
    }
    if (expression.data != null &&
        (!rootReferenceExpressions.contains(checkValidMap['name'])) &&
        (checkValidMap['arguments'] > expression.data.length)) {
      Warning(
          message: 'The expression' +
              exprMap['name'] +
              'has an invalid number of arguments');
      return false;
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
      case 'getArrayItemByKey':
        return getArrayItemByKey(expression);
        break;
      case 'getObjByHierarchicalKey':
        return getObjByHierarchicalKey(expression);
        break;
      case 'getResponseItem':
        return getResponseItem(expression);
        break;
      case 'getSurveyItemValidation':
        return getSurveyItemValidation(expression);
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

  dynamic evaluateArgument(ExpressionArg arg,
      {SurveyContext context,
      dynamic renderedSurvey,
      SurveyGroupItemResponse responses,
      SurveySingleItem temporaryItem}) {
    if (arg == null) {
      return null;
    }
    var argument = getData(arg);
    var result = arg.exp != null
        ? evalExpression(
            expression: argument,
            context: context ?? this.context,
            renderedSurvey: renderedSurvey ?? this.renderedSurvey,
            responses: responses ?? this.responses,
            temporaryItem: temporaryItem ?? this.temporaryItem)
        : argument;
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
  bool getLogicalEvaluation(ExpressionArg arg,
      {SurveyContext context,
      dynamic renderedSurvey,
      SurveyGroupItemResponse responses,
      SurveySingleItem temporaryItem}) {
    switch (arg.exprArgDType.dtype) {
      case 'num':
        return (arg.number > 0);
        break;
      case 'str':
        return (arg.str.length > 0);
        break;
      case 'exp':
        return (evalExpression(
            expression: arg.exp,
            context: context ?? this.context,
            renderedSurvey: renderedSurvey ?? this.renderedSurvey,
            responses: responses ?? this.responses,
            temporaryItem: temporaryItem ?? this.temporaryItem));
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
      Warning(message: 'The expression not has an invalid number of arguments');
      return false;
    }
    return !getLogicalEvaluation(arguments[firstArgument]);
  }

  bool isDefined(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    if (arguments.length > maxUnaryOperands) {
      Warning(
          message:
              'The expression isDefined has an invalid number of arguments');
      return false;
    }
    var argument = getData(arguments[firstArgument]);
    var result = arguments[firstArgument].exp != null
        ? evalExpression(
            expression: argument,
            context: this.context,
            renderedSurvey: this.renderedSurvey,
            responses: this.responses,
            temporaryItem: this.temporaryItem)
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
      Warning(message: 'getAttribute expected second argument to be a string');
    }

    var reference = getData(arguments[firstArgument]);
    var root;
    if (!(reference is Expression)) {
      if (this.temporaryItem == null) {
        Warning(
            message:
                'getAttribute expected first argument is not a valid expression or temporary object to be set');
        return null;
      }
      if (reference == 'this') {
        root = this.temporaryItem;
      }
    } else {
      root = evalExpression(
          expression: reference,
          context: this.context,
          renderedSurvey: this.renderedSurvey,
          responses: this.responses,
          temporaryItem: this.temporaryItem);
    }
    if (root == null) {
      Warning(
          message:
              'getAttribute expected first argument received wrong type of reference object');
      return null;
    }
    try {
      if (!(root is Map)) {
        root = root?.toMap();
      }
    } catch (e) {
      Warning(
          message:
              'getAttribute expected first argument received wrong type of reference object');
      return null;
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
      Warning(
          message: 'getArrayItem: First argument needs to be an expression');
      return null;
    }
    if (!(arg2 is num)) {
      Warning(message: 'getArrayItem: Second argument needs to be a number');
      return null;
    }

    var array = evalExpression(
        expression: arg1,
        context: this.context,
        renderedSurvey: this.renderedSurvey,
        responses: this.responses,
        temporaryItem: this.temporaryItem);
    if (!(array is List) || (array is List && array.length <= arg2)) {
      Warning(
          message:
              'getArrayItem: First argument Expression on evaluation needs to return a list');
      return null;
    }

    var item = array[arg2];
    if (expression.returnType != null) {
      item = Utils.parseExpressionReturnType(
          item: item, returnType: expression.returnType);
    }
    return item;
  }

  dynamic getArrayItemByKey(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var arg1 = getData(arguments[firstArgument]);
    var arg2 = getData(arguments[secondArgument]);

    if (arg1 == null || !(arg1 is Expression)) {
      Warning(
          message:
              'getArrayItemByKey: First argument needs to be an expression');
      return null;
    }
    if (!(arg2 is String)) {
      Warning(
          message: 'getArrayItemByKey: Second argument needs to be a string');
      return null;
    }

    var array = evalExpression(
        expression: arg1,
        context: this.context,
        renderedSurvey: this.renderedSurvey,
        responses: this.responses,
        temporaryItem: this.temporaryItem);
    if (!(array is List)) {
      Warning(
          message:
              'getArrayItemByKey: First argument Expression on evaluation needs to return a list');
      return null;
    }
    var item;
    if (array[firstArgument] is Map) {
      item = array.firstWhere((iterItem) => iterItem['key'] == arg2,
          orElse: () => null);
    } else {
      try {
        item = array.firstWhere((iterItem) => iterItem.key == arg2,
            orElse: () => null);
      } catch (e) {
        Warning(message: 'getArrayItemByKey: Object does not have key');
        return null;
      }
    }
    if (item == null) {
      return null;
    }
    if (expression.returnType != null) {
      item = Utils.parseExpressionReturnType(
          item: item, returnType: expression.returnType);
    }
    return item;
  }

  dynamic getObjByHierarchicalKey(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var arg1 = getData(arguments[firstArgument]);
    var arg2 = getData(arguments[secondArgument]);

    var key = arg2;

    if (arg1 == null || !(arg1 is Expression)) {
      Warning(
          message:
              'getObjByHierarchicalKey: First argument needs to be an expression');
      return null;
    }
    if (!(arg2 is String)) {
      Warning(
          message:
              'getObjByHierarchicalKey: Second argument needs to be a string');
      return null;
    }

    var root = evalExpression(
        expression: arg1,
        context: this.context,
        renderedSurvey: this.renderedSurvey,
        responses: this.responses,
        temporaryItem: this.temporaryItem);
    try {
      if (!(root is Map)) {
        root = root?.toMap();
      }
    } catch (e) {
      Warning(
          message:
              'getObjByHierarchicalKey expected first argument received wrong type of reference object');
      return null;
    }
    if (root == null ||
        ((root['items'] == null || root['items'].length == 0) &&
            root.key != key)) {
      return null;
    }

    if (Utils.getRootKey(root['key']) != Utils.getRootKey(key)) {
      Warning(message: 'getObjByHierarchicalKey: Cannot find object for' + key);
      return null;
    }
    String componentId = root['key'];
    var result = root;
    List<String> ids = key.split(keyHierarchySeperator).sublist(firstItem);
    ids.forEach((id) {
      if (result['items'] == null) {
        return;
      }
      componentId = componentId + keyHierarchySeperator + id;
      var foundItem = result['items']
          .firstWhere((item) => item['key'] == componentId, orElse: () => null);
      if (foundItem == null) {
        Warning(
            message: 'getObjByHierarchicalKey: Cannot find object for' + key);
        result = null;
        return;
      } else
        result = foundItem;
    });
    return result;
  }

  dynamic getResponseItem(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var parentGroup = getData(arguments[firstArgument]);
    var responseItem = getData(arguments[secondArgument]);
    var exprMap = {
      'name': 'getObjByHierarchicalKey',
      'data': [
        {
          'dtype': 'exp',
          'exp': {
            'name': 'getAttribute',
            'data': [
              {
                'dtype': 'exp',
                'exp': {
                  'name': 'getObjByHierarchicalKey',
                  'data': [
                    {
                      'dtype': 'exp',
                      'exp': {'name': 'getResponses'}
                    },
                    {'str': parentGroup}
                  ]
                }
              },
              {'str': 'response'}
            ]
          }
        },
        {'str': responseItem}
      ]
    };
    Expression result = Expression.fromMap(exprMap);
    dynamic evaluate = evalExpression(
        expression: result,
        context: this.context,
        renderedSurvey: this.renderedSurvey,
        responses: this.responses,
        temporaryItem: this.temporaryItem);
    return evaluate;
  }

  bool getSurveyItemValidation(Expression expression) {
    List<ExpressionArg> arguments = expression.data;
    var parentReference = getData(arguments[firstArgument]);
    var surveyItemKey = getData(arguments[secondArgument]);
    var root;
    if (parentReference == 'this') {
      root = this.temporaryItem;
      print("validating item:" + this.temporaryItem.key);
    } else {
      var surveyExpression = {
        'name': 'getObjByHierarchicalKey',
        'data': [
          {
            'dtype': 'exp',
            'exp': {'name': 'getRenderedItems'}
          },
          {'str': parentReference}
        ]
      };
      root = getObjByHierarchicalKey(Expression.fromMap(surveyExpression));
    }
    if (!(parentReference is String)) {
      Warning(
          message:
              'getSurveyItemValidation: First argument needs to be a string');
      return null;
    }

    try {
      if (!(root is Map)) {
        root = root?.toMap();
      }
    } catch (e) {
      Warning(
          message:
              'getSurveyItemValidation expected first argument received wrong type of reference object');
      return null;
    }
    bool result;
    if (root['validations'] == null) {
      result = true;
    }
    var rule = root['validations']
        .firstWhere((iter) => iter['key'] == surveyItemKey, orElse: () => null);
    result = (rule == null)
        ? true
        : Utils.evaluateBooleanResult(Expression.fromMap(rule['rule']),
            context: this.context,
            renderedSurvey: this.renderedSurvey,
            responses: this.responses,
            temporaryItem: this.temporaryItem);
    return result;
  }
}

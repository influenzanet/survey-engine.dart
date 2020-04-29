import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_context.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_item.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:test/test.dart';

import '../../survey_engine_core/survey_item_constants.dart';

void main() {
  group(
      'getObjByHierarchicalKey evaluations throws exceptions on invalid arguments:\n',
      () {
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    Expression expr;
    setUp(() {
      eval = ExpressionEvaluation(
        context: SurveyContext(mode: 'mobile'),
      );
    });

    test(
        'Check getObjByHierarchicalKey throws exception when first argument is null',
        () {
      testExpr = {
        'name': 'getObjByHierarchicalKey',
        'returnType': 'string',
        'data': [
          {'dtype': 'str', 'str': null},
          {'dtype': 'str', 'str': 'mode'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      print('Expression:\n' + json.encode(testExpr));
      expect(() => eval.evalExpression(expression: expr),
          throwsA(TypeMatcher<InvalidArgumentsException>()));
    });
    test(
        'Check getObjByHierarchicalKey throws exception when first argument is not an expression',
        () {
      testExpr = {
        'name': 'getObjByHierarchicalKey',
        'returnType': 'string',
        'data': [
          {'dtype': 'str', 'str': 'something'},
          {'dtype': 'str', 'str': 'mode'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      print('Expression:\n' + json.encode(testExpr));
      expect(() => eval.evalExpression(expression: expr),
          throwsA(TypeMatcher<InvalidArgumentsException>()));
    });

    test(
        'Check getObjByHierarchicalKey throws exception when second argument is not a string',
        () {
      testExpr = {
        'name': 'getObjByHierarchicalKey',
        'data': [
          {
            'dtype': 'exp',
            'exp': {
              'name': 'getAttribute',
              'data': [
                {
                  'dtype': 'exp',
                  'exp': {'name': 'getResponses'}
                },
                {'dtype': 'str', 'str': 'items'}
              ]
            }
          },
          {'dtype': 'num', 'num': 1}
        ]
      };
      expr = Expression.fromMap(testExpr);
      print('Expression:\n' + json.encode(testExpr));
      expect(() => eval.evalExpression(expression: expr),
          throwsA(TypeMatcher<InvalidArgumentsException>()));
    });
  });

  group('getObjByHierarchicalKey valid arguments :\n', () {
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    Expression expr;
    setUp(() {
      eval = ExpressionEvaluation(
          context: SurveyContext(mode: 'mobile'),
          responses:
              SurveyGroupItemResponse.fromMap(testSurveyGroupItemResponseRoot));
      print('Hierarchical key:\n');
      print(json.encode(testSurveyGroupItemResponseRoot));
    });

    test('Check getObjByHierarchicalKey returns appropriate response ', () {
      testExpr = {
        'name': 'getObjByHierarchicalKey',
        'data': [
          {
            'dtype': 'exp',
            'exp': {'name': 'getResponses'}
          },
          {'dtype': 'str', 'str': 'G0.G1.S3'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      print('Expression:\n' + json.encode(testExpr));
      dynamic expected = eval.evalExpression(expression: expr);
      expect(json.encode(expected),
          json.encode(testSurveySingleItemResponseThree));
    });

    test('Check getObjByHierarchicalKey returns appropriate response ', () {
      testExpr = {
        'name': 'getObjByHierarchicalKey',
        'data': [
          {
            'dtype': 'exp',
            'exp': {'name': 'getResponses'}
          },
          {'dtype': 'str', 'str': 'G0.S2'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      print('Expression:\n' + json.encode(testExpr));
      dynamic expected = eval.evalExpression(expression: expr);
      expect(
          json.encode(expected), json.encode(testSurveySingleItemResponseTwo));
    });
  });

  group('getResponseItem valid arguments :\n', () {
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    Expression expr;
    setUp(() {});

    test('Check getResponseItem returns appropriate response ', () {
      var responseRoot = {
        'key': 'TS',
        'meta': {
          'position': 0,
          'localeCode': 'de',
          'version': 1,
          'rendered': [],
          'displayed': [],
          'responded': []
        },
        'items': [
          {
            'key': 'TS.I1',
            'meta': {
              'position': 0,
              'localeCode': 'de',
              'version': 1,
              'rendered': [],
              'displayed': [],
              'responded': []
            },
            'response': {
              'key': 'RG1',
              'items': [
                {'key': 'RG1.R1', 'value': 'testvalue'}
              ]
            }
          }
        ]
      };
      testExpr = {
        'name': 'getResponseItem',
        'data': [
          {'str': 'TS.I1'},
          {'str': 'RG1.R1'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      eval = ExpressionEvaluation(
          context: SurveyContext(mode: 'mobile'),
          responses: SurveyGroupItemResponse.fromMap(responseRoot));
      print('Hierarchical key:\n');
      print('Expression:\n' + json.encode(testExpr));
      var expected = {'key': 'RG1.R1', 'value': 'testvalue'};
      dynamic actual = eval.evalExpression(expression: expr);
      expect(json.encode(actual), json.encode(expected));
    });
  });

  // Will be continued after temporary item is clarified
  // Also write test to cover rendered survey in absence of temporary item
  group('getSurveyItem validations :\n', () {
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    Expression expr;
    var testRenderedSurveyItem;
    setUp(() {
      testRenderedSurveyItem = {
        'key': 'TS',
        'version': 1,
        'type': 'basic.static.title',
        'components': {'role': 'root', 'items': []},
        'validations': [
          {
            'key': 'v1',
            'type': 'hard',
            'rule': {
              'name': 'not',
              'returnType': 'boolean',
              'data': [
                {'dtype': 'num', 'num': 0}
              ]
            }
          },
          {
            'key': 'v2',
            'type': 'hard',
            'rule': {
              'name': 'not',
              'returnType': 'boolean',
              'data': [
                {'dtype': 'num', 'num': 2}
              ]
            }
          }
        ]
      };
      print('Temporary Item:\n' + json.encode(testRenderedSurveyItem));
    });
    test('Check getSurveyItem returns true when validation is true ', () {
      testExpr = {
        'name': 'getSurveyItemValidation',
        'data': [
          {'str': 'this'},
          {'str': 'v1'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      eval = ExpressionEvaluation(
          context: SurveyContext(mode: 'mobile'),
          temporaryItem: SurveyItem(testRenderedSurveyItem));
      print('Expression:\n' + json.encode(testExpr));
      dynamic actual = eval.evalExpression(expression: expr);
      expect(actual, isTrue);
    });
    test('Check getSurveyItem returns true when validation is absent ', () {
      testExpr = {
        'name': 'getSurveyItemValidation',
        'data': [
          {'str': 'this'},
          {'str': 'v3'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      eval = ExpressionEvaluation(
          context: SurveyContext(mode: 'mobile'),
          temporaryItem: SurveyItem(testRenderedSurveyItem));
      print('Expression:\n' + json.encode(testExpr));
      dynamic actual = eval.evalExpression(expression: expr);
      expect(actual, isTrue);
    });
    test('Check getSurveyItem returns false when validation is false ', () {
      testExpr = {
        'name': 'getSurveyItemValidation',
        'data': [
          {'str': 'this'},
          {'str': 'v1'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      eval = ExpressionEvaluation(
          context: SurveyContext(mode: 'mobile'),
          temporaryItem: SurveyItem(testRenderedSurveyItem));
      print('Expression:\n' + json.encode(testExpr));
      dynamic actual = eval.evalExpression(expression: expr);
      expect(actual, isTrue);
    });
  });
}

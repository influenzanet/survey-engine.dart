import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_context.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:test/test.dart';

import '../../survey_engine_core/survey_item_constants.dart';

void main() {
  group(
      'getArrayItemByKey evaluations throws exceptions on invalid arguments:\n',
      () {
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    Expression expr;
    setUp(() {
      eval = ExpressionEvaluation(
        context: SurveyContext(mode: 'mobile'),
      );
    });

    test('Check getArrayItemByKey throws exception when first argument is null',
        () {
      testExpr = {
        'name': 'getArrayItemByKey',
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
        'Check getArrayItemByKey throws exception when first argument is not an expression',
        () {
      testExpr = {
        'name': 'getArrayItemByKey',
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
        'Check getArrayItemByKey throws exception when second argument is not a number',
        () {
      testExpr = {
        'name': 'getArrayItemByKey',
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
          {'dtype': 'str', 'str': '1'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      print('Expression:\n' + json.encode(testExpr));
      expect(() => eval.evalExpression(expression: expr),
          throwsA(TypeMatcher<InvalidArgumentsException>()));
    });
  });

  group('getArrayItemByKey valid arguments :\n', () {
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    Expression expr;
    setUp(() {
      eval = ExpressionEvaluation(
          context: SurveyContext(mode: 'mobile'),
          responses:
              SurveyGroupItemResponse.fromMap(testSurveyGroupItemResponseOne));
      print('Response tree:\n' + json.encode(testSurveyGroupItemResponseOne));
    });

    test('Check getArrayItemByKey returns appropriate key response ', () {
      testExpr = {
        'name': 'getArrayItemByKey',
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
          {'dtype': 'str', 'str': 'G0.G1.S3'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      print('Expression:\n' + json.encode(testExpr));
      dynamic expected = eval.evalExpression(expression: expr);
      expect(json.encode(expected),
          json.encode(testSurveySingleItemResponseThree));
    });

    test(
        'Check getArrayItemByKey throws exception on valid arguments but invalid index ',
        () {
      testExpr = {
        'name': 'getArrayItemByKey',
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
          {'dtype': 'str', 'str': 'G0.G1.S4'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      print('Expression:\n' + json.encode(testExpr));
      expect(eval.evalExpression(expression: expr), isNull);
    });
  });
}

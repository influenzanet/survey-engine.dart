import 'dart:convert';

import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_context.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:test/test.dart';

import '../../survey_engine_core/survey_item_constants.dart';

void main() {
  group(
      'getArrayItemAtIndex evaluations defaults to nulls on invalid arguments:\n',
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
        'Check getArrayItemAtIndex defaults to null when first argument is null',
        () {
      testExpr = {
        'name': 'getArrayItemAtIndex',
        'returnType': 'string',
        'data': [
          {'dtype': 'str', 'str': null},
          {'dtype': 'str', 'str': 'mode'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      print('Expression:\n' + json.encode(testExpr));
      expect(eval.evalExpression(expression: expr), isNull);
    });
    test(
        'Check getArrayItemAtIndex defaults to null when first argument is not an expression',
        () {
      testExpr = {
        'name': 'getArrayItemAtIndex',
        'returnType': 'string',
        'data': [
          {'dtype': 'str', 'str': 'something'},
          {'dtype': 'str', 'str': 'mode'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      print('Expression:\n' + json.encode(testExpr));
      expect(eval.evalExpression(expression: expr), isNull);
    });

    test(
        'Check getArrayItemAtIndex defaults to null when second argument is not a number',
        () {
      testExpr = {
        'name': 'getArrayItemAtIndex',
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
      expect(eval.evalExpression(expression: expr), isNull);
    });
  });

  group('getArrayItemAtIndex valid arguments :\n', () {
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

    test('Check getArrayItemAtIndex returns appropriate index response ', () {
      testExpr = {
        'name': 'getArrayItemAtIndex',
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
          {'dtype': 'num', 'num': 0}
        ]
      };
      expr = Expression.fromMap(testExpr);
      print('Expression:\n' + json.encode(testExpr));
      dynamic expected = eval.evalExpression(expression: expr);
      expect(json.encode(expected),
          json.encode(testSurveySingleItemResponseThree));
    });

    test(
        'Check getArrayItemAtIndex defaults to null on valid arguments but invalid index ',
        () {
      testExpr = {
        'name': 'getArrayItemAtIndex',
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
      expect(eval.evalExpression(expression: expr), isNull);
    });
  });
}

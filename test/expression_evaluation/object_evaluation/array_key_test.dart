import 'dart:collection';
import 'dart:convert';

import 'package:influenzanet_survey_engine/src/controller/expression_eval.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_context.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:test/test.dart';

import '../../survey_engine_core/survey_item_constants.dart';

void main() {
  group(
      'getArrayItemByKey evaluations defaults to null on invalid arguments:\n',
      () {
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    Expression expr;
    setUp(() {
      eval = ExpressionEvaluation(
        context: SurveyContext(mode: 'mobile'),
      );
    });

    test('Check getArrayItemByKey defaults to null when first argument is null',
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
      expect(eval.evalExpression(expression: expr), isNull);
    });
    test(
        'Check getArrayItemByKey defaults to null when first argument is not an expression',
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
      expect(eval.evalExpression(expression: expr), isNull);
    });

    test(
        'Check getArrayItemByKey defaults to null when second argument is not a number',
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
      expect(eval.evalExpression(expression: expr), isNull);
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
      expect(json.encode(HashMap.from(expected)),
          json.encode(HashMap.from(testSurveySingleItemResponseThree)));
    });

    test(
        'Check getArrayItemByKey defaults to null on valid arguments but invalid index ',
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

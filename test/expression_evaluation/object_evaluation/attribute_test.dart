import 'dart:convert';

import 'package:influenzanet_survey_engine/src/controller/expression_eval.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_context.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_single_item.dart';
import 'package:test/test.dart';

import '../../survey_engine_core/survey_item_constants.dart';

void main() {
  group('getAttribute evaluations:\n', () {
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    Expression expr;
    setUp(() {
      eval = ExpressionEvaluation(
        context: SurveyContext(mode: 'mobile'),
      );
      testExpr = {
        'name': 'getAttribute',
        'returnType': 'string',
        'data': [
          {
            'dtype': 'exp',
            'exp': {'name': 'getContext'}
          },
          {'dtype': 'str', 'str': 'mode'}
        ]
      };
      expr = Expression.fromMap(testExpr);
    });

    test('Check getAttribute when default context mode:`mobile` is set', () {
      print('Expression:\n' + json.encode(testExpr));
      dynamic expected = eval.evalExpression(expression: expr);
      expect(expected, 'mobile');
    });

    test('Check getAttribute for type other than string', () {
      eval = ExpressionEvaluation(
        context: SurveyContext(mode: 'mobile', profile: 3.14),
      );
      testExpr = {
        'name': 'getAttribute',
        'returnType': 'float',
        'data': [
          {
            'dtype': 'exp',
            'exp': {'name': 'getContext'}
          },
          {'dtype': 'str', 'str': 'profile'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      print('Expression:\n' + json.encode(testExpr));
      dynamic expected = eval.evalExpression(expression: expr);
      expect(expected, 3.14);
    });

    test(
        'Check expression if reference is not an expression and temporary item is not set',
        () {
      testExpr = {
        'name': 'getAttribute',
        'returnType': 'string',
        'data': [
          {'dtype': 'str', 'str': 'hello'},
          {'dtype': 'str', 'str': 'mode'}
        ]
      };
      print('Expression:\n' + json.encode(testExpr));

      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isNull);
    });

    test(
        'Check getAttribute when reference is not an expression and temporary item is set',
        () {
      testExpr = {
        'name': 'getAttribute',
        'returnType': 'string',
        'data': [
          {'dtype': 'str', 'str': 'this'},
          {'dtype': 'str', 'str': 'key'}
        ]
      };
      print('Expression:\n' + json.encode(testExpr));
      expr = Expression.fromMap(testExpr);
      eval = ExpressionEvaluation(
          context: SurveyContext(mode: 'mobile'),
          temporaryItem: SurveySingleItem.fromMap(testSurveySingleItemOne));
      dynamic expected = eval.evalExpression(expression: expr);
      expect(expected, 'G0.S1');
    });
  });
}

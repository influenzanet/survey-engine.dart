import 'dart:collection';
import 'dart:convert';

import 'package:influenzanet_survey_engine/src/controller/expression_eval.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_context.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:test/test.dart';

import '../../survey_engine_core/survey_item_constants.dart';

void main() {
  group('getContext evaluations:\n', () {
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    Expression expr;
    setUp(() {
      eval = ExpressionEvaluation(
          context: SurveyContext(mode: 'mobile'),
          renderedSurvey: renderedSurveyGroupRoot,
          responses:
              SurveyGroupItemResponse.fromMap(testSurveyGroupItemResponseOne));
      testExpr = {
        'name': 'getContext',
      };

      print('Context: \n' +
          SurveyContext(mode: 'mobile').toJson() +
          'Rendered Survey: \n' +
          json.encode(renderedSurveyGroupRoot) +
          'Responses: \n' +
          json.encode(testSurveyGroupItemResponseOne));
    });

    test('Check getContext when default context mode:`mobile` is set', () {
      expr = Expression.fromMap(testExpr);
      SurveyContext expected = eval.evalExpression(expression: expr);
      expect(expected.mode, 'mobile');
    });
    test('Check getRenderedItems', () {
      testExpr = {
        'name': 'getRenderedItems',
      };
      expr = Expression.fromMap(testExpr);
      dynamic expected = eval.evalExpression(expression: expr);
      expect(json.encode(HashMap.from(expected)),
          json.encode(HashMap.from(renderedSurveyGroupRoot)));
    });
    test('Check getResponses', () {
      testExpr = {
        'name': 'getResponses',
      };
      expr = Expression.fromMap(testExpr);
      SurveyGroupItemResponse expected = eval.evalExpression(expression: expr);
      expect(expected.toJson(),
          json.encode(HashMap.from(testSurveyGroupItemResponseOne)));
    });
  });
}

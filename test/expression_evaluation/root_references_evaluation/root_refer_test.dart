import 'dart:convert';

import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_context.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_group_item_response.dart';
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
      expr = Expression.fromMap(testExpr);
      print('Context: \n' +
          SurveyContext(mode: 'mobile').toJson() +
          'Rendered Survey: \n' +
          json.encode(renderedSurveyGroupRoot) +
          'Responses: \n' +
          json.encode(testSurveyGroupItemResponseOne));
    });

    test('Check getContext when default context mode:`mobile` is set', () {
      SurveyContext expected = eval.evalExpression(expression: expr);
      expect(expected.mode, 'mobile');
    });
    test('Check getRendredSurvey', () {
      dynamic expected = eval.getRenderedItems();
      expect(json.encode(expected), json.encode(renderedSurveyGroupRoot));
    });
    test('Check getResponses', () {
      SurveyGroupItemResponse expected = eval.getResponses();
      expect(expected.toJson(), json.encode(testSurveyGroupItemResponseOne));
    });
  });
}

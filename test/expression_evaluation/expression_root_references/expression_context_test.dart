import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_context.dart';
import 'package:test/test.dart';

void main() {
  group('getContext evaluations:\n', () {
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    Expression expr;
    setUp(() {
      eval = ExpressionEvaluation(context: SurveyContext(mode: 'mobile'));
      testExpr = {
        'name': 'getContext',
      };
      expr = Expression.fromMap(testExpr);
    });

    test(
        'Check getContext when default context mode:`mobile` is set and no other context is passed',
        () {
      SurveyContext expected = eval.evalExpression(expression: expr);
      expect(expected.mode, 'mobile');
    });

    test(
        'SurveyContext mode:test is passed externally returns a context object',
        () {
      SurveyContext expected = eval.evalExpression(
          expression: expr, context: SurveyContext(mode: 'test'));
      expect(expected.mode, 'test');
    });

    test('Throw exception when no context is set or passed', () {
      eval = ExpressionEvaluation();

      expect(() => eval.evalExpression(expression: expr),
          throwsA(TypeMatcher<InvalidContextException>()));
    });
  });
}

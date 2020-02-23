import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:test/test.dart';

void main() {
  group(
      'isDefined evaluations: Any evaluation other than null is considered true:\n',
      () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    setUp(() {
      eval = ExpressionEvaluation();
    });
    test(
        'Check isFalse for data having an integer data type but containing a string value (null number) ',
        () {
      testExpr = {
        'name': 'isDefined',
        'data': [
          {'dType': 'number', 'str': '5'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isFalse);
    });
    test('Check isTrue for numbers (2)', () {
      testExpr = {
        'name': 'isDefined',
        'data': [
          {'dType': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
  });
}

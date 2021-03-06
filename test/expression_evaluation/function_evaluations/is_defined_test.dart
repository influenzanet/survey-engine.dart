import 'package:influenzanet_survey_engine/src/controller/expression_eval.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
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
        'Check isFalse for data having an integer data type but containing a string value (null num) ',
        () {
      testExpr = {
        'name': 'isDefined',
        'data': [
          {'dtype': 'num', 'str': '5'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
    test('Check isTrue for nums (2)', () {
      testExpr = {
        'name': 'isDefined',
        'data': [
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isTrue);
    });
  });
}

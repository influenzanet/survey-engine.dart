import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:test/test.dart';

void main() {
  group('NOT comparisons: Only 0s and empty strings are considered False:\n',
      () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    setUp(() {
      eval = ExpressionEvaluation();
    });
    test('Check isFalse for nums !(2)', () {
      testExpr = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });

    test('Check isTrue for nums !(0)', () {
      testExpr = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 0}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isTrue);
    });

    test('Check for strings isFalse !(ab)', () {
      testExpr = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': 'ab'},
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
    test('Check for strings isTrue for !(\'\')', () {
      testExpr = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': ''}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isTrue);
    });
  });
}

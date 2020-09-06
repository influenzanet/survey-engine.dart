import 'package:influenzanet_survey_engine/src/controller/expression_eval.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
import 'package:test/test.dart';

void main() {
  group('Equal to comparisons:\n', () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    setUp(() {
      eval = ExpressionEvaluation();
    });

    test('Check isTrue for nums (1==1)', () {
      testExpr = {
        'name': 'eq',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 1},
          {'dtype': 'num', 'num': 1}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isTrue);
    });
    test('Check for nums isFalse (1==2)', () {
      testExpr = {
        'name': 'eq',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 1},
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
    test('Check for strings isTrue (ab==ab)', () {
      testExpr = {
        'name': 'eq',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': 'ab'},
          {'dtype': 'str', 'str': 'ab'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isTrue);
    });
    test('Check for strings isFalse (ab==bc)', () {
      testExpr = {
        'name': 'eq',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': 'ab'},
          {'dtype': 'str', 'str': 'bc'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
  });

  group('Equality comparisons for invalid cases default to False:\n', () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    setUp(() {
      eval = ExpressionEvaluation();
    });

       
    test('Check isFalse for empty operands', () {
      testExpr = {
        'name': 'eq',
        'returnType': 'boolean',
        'data': [
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });

      test('Check isFalse for single operand', () {
      testExpr = {
        'name': 'eq',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': 'ab'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
  });
}

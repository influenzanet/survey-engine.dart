import 'package:influenzanet_survey_engine/src/controller/expression_eval.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
import 'package:test/test.dart';

void main() {
  group('OR comparisons: Only 0s and empty strings are considered False:\n',
      () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    setUp(() {
      eval = ExpressionEvaluation();
    });

    test('Check isTrue for nums (2||1)', () {
      testExpr = {
        'name': 'or',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 2},
          {'dtype': 'num', 'num': 1}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isTrue);
    });
    test('Check isFalse for nums (0||0)', () {
      testExpr = {
        'name': 'or',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 0},
          {'dtype': 'num', 'num': 0}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
    test('Check isTrue for nums (1||0)', () {
      testExpr = {
        'name': 'or',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 1},
          {'dtype': 'num', 'num': 0}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isTrue);
    });

    test('Check for strings isFalse for (\'\'||\'\')', () {
      testExpr = {
        'name': 'or',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': ''},
          {'dtype': 'str', 'str': ''}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
    test('Check for strings isTrue (ab||bc)', () {
      testExpr = {
        'name': 'or',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': 'ab'},
          {'dtype': 'str', 'str': 'bc'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isTrue);
    });
    test('Check for strings isTrue (ab||\'\')', () {
      testExpr = {
        'name': 'or',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': 'ab'},
          {'dtype': 'str', 'str': ''}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isTrue);
    });
  });

  group('OR comparisons for invalid cases default to False:\n', () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    setUp(() {
      eval = ExpressionEvaluation();
    });

       
    test('Check isFalse for empty operands', () {
      testExpr = {
        'name': 'or',
        'returnType': 'boolean',
        'data': [
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });

      test('Check isFalse for single operand', () {
      testExpr = {
        'name': 'or',
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

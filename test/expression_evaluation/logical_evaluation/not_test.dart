import 'package:influenzanet_survey_engine/src/controller/expression_eval.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
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

  group('NOT comparisons for invalid cases default to False:\n', () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    setUp(() {
      eval = ExpressionEvaluation();
    });

    test('Check isFalse for empty operands', () {
      testExpr = {'name': 'not', 'returnType': 'boolean', 'data': []};
      print(testExpr);
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });

    test('Check isFalse for more than one operand', () {
      testExpr = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': 'ab'},
          {'dtype': 'str', 'str': 'ab'},
        ]
      };
      print(testExpr);
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
  });
}

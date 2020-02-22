import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:test/test.dart';

void main() {
  group('AND comparisons 0s and empty strings are considered False:\n', () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    setUp(() {
      eval = ExpressionEvaluation();
    });

    test('Check isTrue for numbers (1&&1)', () {
      testExpr = {
        'name': 'and',
        'returnType': 'boolean',
        'data': [
          {'dType': 'number', 'number': 1},
          {'dType': 'number', 'number': 1}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check isTrue for numbers (1&&2)', () {
      testExpr = {
        'name': 'and',
        'returnType': 'boolean',
        'data': [
          {'dType': 'number', 'number': 1},
          {'dType': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });

    test('Check isFalse for numbers (1&&0)', () {
      testExpr = {
        'name': 'and',
        'returnType': 'boolean',
        'data': [
          {'dType': 'number', 'number': 1},
          {'dType': 'number', 'number': 0}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isFalse);
    });
    test('Check for strings isTrue (ab&&bc))', () {
      testExpr = {
        'name': 'and',
        'returnType': 'boolean',
        'data': [
          {'dType': 'str', 'str': 'ab'},
          {'dType': 'str', 'str': 'bc'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check for strings isFalse for (ab&&\'\'))', () {
      testExpr = {
        'name': 'and',
        'returnType': 'boolean',
        'data': [
          {'dType': 'str', 'str': 'ab'},
          {'dType': 'str', 'str': ''}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isFalse);
    });
  });
}

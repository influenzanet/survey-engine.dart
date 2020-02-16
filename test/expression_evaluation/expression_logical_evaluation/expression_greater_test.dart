import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:test/test.dart';

void main() {
  group('Greater than comparisons:\n', () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    setUp(() {
      eval = ExpressionEvaluation();
    });

    test('Check isTrue for numbers', () {
      testExpr = {
        'name': 'gt',
        'returnType': 'boolean',
        'data': [
          {'dType': 'number', 'number': 2},
          {'dType': 'number', 'number': 1}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check for numbers isFalse', () {
      testExpr = {
        'name': 'gt',
        'returnType': 'boolean',
        'data': [
          {'dType': 'number', 'number': 1},
          {'dType': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isFalse);
    });
    test('Check for strings isTrue', () {
      testExpr = {
        'name': 'gt',
        'returnType': 'boolean',
        'data': [
          {'dType': 'str', 'str': 'bc'},
          {'dType': 'str', 'str': 'ab'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check for strings isFalse', () {
      testExpr = {
        'name': 'gt',
        'returnType': 'boolean',
        'data': [
          {'dType': 'str', 'str': 'ab'},
          {'dType': 'str', 'str': 'bc'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isFalse);
    });
  });
  group('Greater or Equal to comparisons:\n', () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    setUp(() {
      eval = ExpressionEvaluation();
    });

    test('Check greater for numbers isTrue', () {
      testExpr = {
        'name': 'gte',
        'returnType': 'boolean',
        'data': [
          {'dType': 'number', 'number': 2},
          {'dType': 'number', 'number': 1}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check equality for numbers isTrue', () {
      testExpr = {
        'name': 'gte',
        'returnType': 'boolean',
        'data': [
          {'dType': 'number', 'number': 1},
          {'dType': 'number', 'number': 1}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check lesser for numbers isFalse', () {
      testExpr = {
        'name': 'gte',
        'returnType': 'boolean',
        'data': [
          {'dType': 'number', 'number': 1},
          {'dType': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isFalse);
    });
    test('Check equality for strings isTrue', () {
      testExpr = {
        'name': 'gte',
        'returnType': 'boolean',
        'data': [
          {'dType': 'str', 'str': 'ab'},
          {'dType': 'str', 'str': 'ab'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check greater for strings isTrue', () {
      testExpr = {
        'name': 'gte',
        'returnType': 'boolean',
        'data': [
          {'dType': 'str', 'str': 'bc'},
          {'dType': 'str', 'str': 'ab'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });

    test('Check lesser for strings isFalse', () {
      testExpr = {
        'name': 'gte',
        'returnType': 'boolean',
        'data': [
          {'dType': 'str', 'str': 'ab'},
          {'dType': 'str', 'str': 'bc'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isFalse);
    });
  });
}

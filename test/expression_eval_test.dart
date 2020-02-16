import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:test/test.dart';

void main() {
  group('Lesser than comparisons:\n', () {
    Expression expr;
    Map<String, Object> testExpr;
    setUp(() {});

    test('Check isFalse for numbers', () {
      testExpr = {
        'name': 'lt',
        'returnType': 'boolean',
        'data': [
          {'dType': 'number', 'number': 1},
          {'dType': 'number', 'number': 1}
        ]
      };
      expr = Expression.fromMap(testExpr);
      ExpressionEvaluation eval = ExpressionEvaluation(expr: expr);
      print(testExpr.toString());
      expect(eval.evalExpression(expr), isFalse);
    });
    test('Check for numbers isTrue', () {
      testExpr = {
        'name': 'lt',
        'returnType': 'boolean',
        'data': [
          {'dType': 'number', 'number': 1},
          {'dType': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      ExpressionEvaluation eval = ExpressionEvaluation(expr: expr);
      print(testExpr.toString());
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check for strings isFalse', () {
      testExpr = {
        'name': 'lt',
        'returnType': 'boolean',
        'data': [
          {'dType': 'str', 'str': 'bc'},
          {'dType': 'str', 'str': 'ab'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      ExpressionEvaluation eval = ExpressionEvaluation(expr: expr);
      print(testExpr.toString());
      expect(eval.evalExpression(expr), isFalse);
    });
    test('Check for strings isTrue', () {
      testExpr = {
        'name': 'lt',
        'returnType': 'boolean',
        'data': [
          {'dType': 'str', 'str': 'ab'},
          {'dType': 'str', 'str': 'bc'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      ExpressionEvaluation eval = ExpressionEvaluation(expr: expr);
      print(testExpr.toString());
      expect(eval.evalExpression(expr), isTrue);
    });
  });

  group('Greater than comparisons:\n', () {
    Expression expr;
    Map<String, Object> testExpr;
    setUp(() {});

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
      ExpressionEvaluation eval = ExpressionEvaluation(expr: expr);
      print(testExpr.toString());
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
      ExpressionEvaluation eval = ExpressionEvaluation(expr: expr);
      print(testExpr.toString());
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
      ExpressionEvaluation eval = ExpressionEvaluation(expr: expr);
      print(testExpr.toString());
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
      ExpressionEvaluation eval = ExpressionEvaluation(expr: expr);
      print(testExpr.toString());
      expect(eval.evalExpression(expr), isFalse);
    });
  });
}

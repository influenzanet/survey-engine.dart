import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:test/test.dart';

void main() {
  group('Expression validity tests:\n', () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    setUp(() {
      eval = ExpressionEvaluation();
    });

    test(
        'Single argument provided for binary operator gt catches invalid exception',
        () {
      testExpr = {
        'name': 'gt',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(() => eval.evalExpression(expr),
          throwsA(TypeMatcher<ArgumentCountException>()));
    });
    test(
        'Single argument provided for binary operator lt catches invalid exception',
        () {
      testExpr = {
        'name': 'lt',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(() => eval.evalExpression(expr),
          throwsA(TypeMatcher<ArgumentCountException>()));
    });

    test(
        'Single argument provided for binary operator lte catches invalid exception',
        () {
      testExpr = {
        'name': 'lte',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(() => eval.evalExpression(expr),
          throwsA(TypeMatcher<ArgumentCountException>()));
    });
    test(
        'Single argument provided for binary operator gte catches invalid exception',
        () {
      testExpr = {
        'name': 'gte',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(() => eval.evalExpression(expr),
          throwsA(TypeMatcher<ArgumentCountException>()));
    });
    test(
        'Single argument provided for binary operator and catches invalid exception',
        () {
      testExpr = {
        'name': 'and',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(() => eval.evalExpression(expr),
          throwsA(TypeMatcher<ArgumentCountException>()));
    });
    test(
        'Single argument provided for binary operator or catches invalid exception',
        () {
      testExpr = {
        'name': 'or',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(() => eval.evalExpression(expr),
          throwsA(TypeMatcher<ArgumentCountException>()));
    });
    test('Two arguments for unary operator not catches invalid exception', () {
      testExpr = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'number', 'number': 2},
          {'dtype': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(() => eval.evalExpression(expr),
          throwsA(TypeMatcher<ArgumentCountException>()));
    });

    test('Two arguments for unary operator isDefined catches invalid exception',
        () {
      testExpr = {
        'name': 'isDefined',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'number', 'number': 2},
          {'dtype': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(() => eval.evalExpression(expr),
          throwsA(TypeMatcher<ArgumentCountException>()));
    });
    test('Invalid operation', () {
      testExpr = {
        'name': 'dummy',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'number', 'number': 2},
          {'dtype': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(() => eval.evalExpression(expr),
          throwsA(TypeMatcher<InvalidArgumentsException>()));
    });
  });
}

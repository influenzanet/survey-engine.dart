import 'package:influenzanet_survey_engine/src/controller/expression_eval.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
import 'package:test/test.dart';

void main() {
  group('Expression validity tests:\n', () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    setUp(() {
      eval = ExpressionEvaluation();
    });

    test('Single argument provided for binary operator throws false', () {
      testExpr = {
        'name': 'gt',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
    test('Single argument provided for binary operator lt defaultsFalse', () {
      testExpr = {
        'name': 'lt',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });

    test('Single argument provided for binary operator lte defaults to false',
        () {
      testExpr = {
        'name': 'lte',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
    test('Single argument provided for binary operator gte defaults to false',
        () {
      testExpr = {
        'name': 'gte',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
    test('Single argument provided for binary operator defaults to False', () {
      testExpr = {
        'name': 'and',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
    test('Single argument provided for binary operator or defaults to False',
        () {
      testExpr = {
        'name': 'or',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
    test('Two arguments for unary operator not defaults to False', () {
      testExpr = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 2},
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });

    test('Two arguments for unary operator isDefined defaults to False', () {
      testExpr = {
        'name': 'isDefined',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 2},
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
    test('Invalid operation prints out a warning and defaults to false', () {
      testExpr = {
        'name': 'dummy',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 2},
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expression: expr), isFalse);
    });
  });
}

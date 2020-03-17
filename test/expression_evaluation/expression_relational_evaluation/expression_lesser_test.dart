import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:test/test.dart';

void main() {
  group('Lesser than comparisons:\n', () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testExpr;
    setUp(() {
      eval = ExpressionEvaluation();
    });

    test('Check isFalse for nums (1<=1)', () {
      testExpr = {
        'name': 'lt',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 1},
          {'dtype': 'num', 'num': 1}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isFalse);
      expr.name = 'lte';
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check for nums isTrue (1<=2)', () {
      testExpr = {
        'name': 'lt',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 1},
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check equal for nums isTrue (1<=1)', () {
      testExpr = {
        'name': 'lte',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 1},
          {'dtype': 'num', 'num': 1}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check for strings isFalse (bc<=ab)', () {
      testExpr = {
        'name': 'lt',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': 'bc'},
          {'dtype': 'str', 'str': 'ab'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isFalse);
    });
    test('Check for strings isTrue (ab<=bc)', () {
      testExpr = {
        'name': 'lt',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': 'ab'},
          {'dtype': 'str', 'str': 'bc'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check equality for strings isTrue (ab<=ab)', () {
      testExpr = {
        'name': 'lte',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': 'ab'},
          {'dtype': 'str', 'str': 'ab'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
  });
}

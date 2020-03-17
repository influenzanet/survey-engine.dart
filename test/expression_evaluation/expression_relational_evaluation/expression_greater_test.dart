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

    test('Check for nums isFalse (1>=2)', () {
      testExpr = {
        'name': 'gt',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 1},
          {'dtype': 'num', 'num': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isFalse);
    });
    test('Check isTrue for nums (2>=1)', () {
      testExpr = {
        'name': 'gt',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 2},
          {'dtype': 'num', 'num': 1}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check equality for nums isTrue (1>=1)', () {
      testExpr = {
        'name': 'gte',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'num', 'num': 1},
          {'dtype': 'num', 'num': 1}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });

    test('Check for strings isFalse (ab>=bc)', () {
      testExpr = {
        'name': 'gt',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': 'ab'},
          {'dtype': 'str', 'str': 'bc'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isFalse);
    });
    test('Check for strings isTrue (bc>=ab)', () {
      testExpr = {
        'name': 'gt',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': 'bc'},
          {'dtype': 'str', 'str': 'ab'}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });

    test('Check equality for strings isTrue (ab==ab)', () {
      testExpr = {
        'name': 'gte',
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

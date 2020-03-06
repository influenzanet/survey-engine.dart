import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
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

    test('Check isTrue for numbers (2||1)', () {
      testExpr = {
        'name': 'or',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'number', 'number': 2},
          {'dtype': 'number', 'number': 1}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
    });
    test('Check isFalse for numbers (0||0)', () {
      testExpr = {
        'name': 'or',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'number', 'number': 0},
          {'dtype': 'number', 'number': 0}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isFalse);
    });
    test('Check isTrue for numbers (1||0)', () {
      testExpr = {
        'name': 'or',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'number', 'number': 1},
          {'dtype': 'number', 'number': 0}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(eval.evalExpression(expr), isTrue);
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
      expect(eval.evalExpression(expr), isFalse);
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
      expect(eval.evalExpression(expr), isTrue);
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
      expect(eval.evalExpression(expr), isTrue);
    });
  });
}

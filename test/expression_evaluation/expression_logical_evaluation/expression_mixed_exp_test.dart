import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:test/test.dart';

// Need to think of a better way to test all kinds of mixed expressions
void main() {
  group(
      'NOR and NAND comparisons: Only 0s and empty strings are considered False:\n',
      () {
    Expression expr;
    ExpressionEvaluation eval;
    Map<String, Object> testNested;
    setUp(() {
      eval = ExpressionEvaluation();
    });

    test('Check isFalse for numbers !(2||1)', () {
      testNested = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {
            'dType': 'exp',
            'exp': {
              'name': 'or',
              'returnType': 'boolean',
              'data': [
                {'dType': 'number', 'number': 2},
                {'dType': 'number', 'number': 1}
              ]
            }
          }
        ]
      };
      expr = Expression.fromMap(testNested);
      expect(eval.evalExpression(expr), isFalse);
    });

    test('Check isTrue for numbers !(0||0)', () {
      testNested = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {
            'dType': 'exp',
            'exp': {
              'name': 'or',
              'returnType': 'boolean',
              'data': [
                {'dType': 'number', 'number': 0},
                {'dType': 'number', 'number': 0}
              ]
            }
          }
        ]
      };
      expr = Expression.fromMap(testNested);
      expect(eval.evalExpression(expr), isTrue);
    });

    test('Check isFalse for numbers !(1&&1)', () {
      testNested = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {
            'dType': 'exp',
            'exp': {
              'name': 'and',
              'returnType': 'boolean',
              'data': [
                {'dType': 'number', 'number': 1},
                {'dType': 'number', 'number': 1}
              ]
            }
          }
        ]
      };
      expr = Expression.fromMap(testNested);
      expect(eval.evalExpression(expr), isFalse);
    });

    test('Check isTrue for numbers !(0&&1)', () {
      testNested = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {
            'dType': 'exp',
            'exp': {
              'name': 'and',
              'returnType': 'boolean',
              'data': [
                {'dType': 'number', 'number': 0},
                {'dType': 'number', 'number': 1}
              ]
            }
          }
        ]
      };
      expr = Expression.fromMap(testNested);
      expect(eval.evalExpression(expr), isTrue);
    });
  });
}

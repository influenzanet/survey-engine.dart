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

    test('Check isFalse for nums !(2||1)', () {
      testNested = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {
            'dtype': 'exp',
            'exp': {
              'name': 'or',
              'returnType': 'boolean',
              'data': [
                {'dtype': 'num', 'num': 2},
                {'dtype': 'num', 'num': 1}
              ]
            }
          }
        ]
      };
      expr = Expression.fromMap(testNested);
      expect(eval.evalExpression(expression: expr), isFalse);
    });

    test('Check isTrue for nums !(0||0)', () {
      testNested = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {
            'dtype': 'exp',
            'exp': {
              'name': 'or',
              'returnType': 'boolean',
              'data': [
                {'dtype': 'num', 'num': 0},
                {'dtype': 'num', 'num': 0}
              ]
            }
          }
        ]
      };
      expr = Expression.fromMap(testNested);
      expect(eval.evalExpression(expression: expr), isTrue);
    });

    test('Check isFalse for nums !(1&&1)', () {
      testNested = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {
            'dtype': 'exp',
            'exp': {
              'name': 'and',
              'returnType': 'boolean',
              'data': [
                {'dtype': 'num', 'num': 1},
                {'dtype': 'num', 'num': 1}
              ]
            }
          }
        ]
      };
      expr = Expression.fromMap(testNested);
      expect(eval.evalExpression(expression: expr), isFalse);
    });

    test('Check isTrue for nums !(0&&1)', () {
      testNested = {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {
            'dtype': 'exp',
            'exp': {
              'name': 'and',
              'returnType': 'boolean',
              'data': [
                {'dtype': 'num', 'num': 0},
                {'dtype': 'num', 'num': 1}
              ]
            }
          }
        ]
      };
      expr = Expression.fromMap(testNested);
      expect(eval.evalExpression(expression: expr), isTrue);
    });
  });
}

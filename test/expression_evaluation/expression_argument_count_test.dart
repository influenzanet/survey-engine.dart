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
          {'dType': 'number', 'number': 2}
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
          {'dType': 'number', 'number': 2},
          {'dType': 'number', 'number': 2}
        ]
      };
      expr = Expression.fromMap(testExpr);
      expect(() => eval.evalExpression(expr),
          throwsA(TypeMatcher<InvalidArgumentsException>()));
    });
  });
}

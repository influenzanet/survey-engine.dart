import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg_dtype.dart';
import 'package:test/test.dart';

void main() {
  group('Init tests:\n', () {
    ExpressionArgDType argDType;
    ExpressionArg exprArg;
    String ret;
    var testExpr, testExprArg;

    setUp(() {
      argDType = ExpressionArgDType(dataType: 'number');
      exprArg = ExpressionArg(dType: argDType, number: 1);
      ret = 'int';

      testExprArg = {'dType': 'number', 'number': 1};
      testExpr = {
        'name': 'or',
        'returnType': 'int',
        'data': [
          {'dType': 'number', 'number': 1}
        ]
      };
    });

    test('Expression Arg object creation', () {
      ExpressionArg actual = ExpressionArg.fromMap(testExprArg);
      expect(actual, exprArg);
    });

    test('Expression Arg array object creation', () {
      List<ExpressionArg> actualArray = [ExpressionArg.fromMap(testExprArg)];
      List<ExpressionArg> testExprArgArray = [exprArg];
      expect(actualArray, testExprArgArray);
    });

    test('Expression object creation', () {
      List<ExpressionArg> testExprArgArray = [exprArg];
      Expression expr =
          Expression(name: 'or', returnType: ret, data: testExprArgArray);
      Expression actualExpression = Expression.fromMap(testExpr);
      expect(actualExpression, expr);
    });
  });
}

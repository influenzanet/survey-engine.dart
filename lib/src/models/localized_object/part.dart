import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg_dtype.dart';

class Part extends ExpressionArg {
  Part({
    ExpressionArgDType dType,
    Expression exp,
    String str,
  }) : super(dType: dType, exp: exp, str: str, number: null) {
    if (exp.returnType != 'string' || dType.dType == 'num') {
      throw InvalidArgumentsException();
    }
  }
}

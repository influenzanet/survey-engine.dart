import 'package:influenzanet_survey_engine/src/controller/exceptions.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression_arg.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression_arg_dtype.dart';

class Part extends ExpressionArg {
  Part({
    ExpressionArgDType exprArgDType,
    Expression exp,
    String str,
  }) : super(exprArgDType: exprArgDType, exp: exp, str: str, number: null) {
    if (exp.returnType != 'string' || exprArgDType.dtype == 'num') {
      throw InvalidArgumentsException();
    }
  }
}

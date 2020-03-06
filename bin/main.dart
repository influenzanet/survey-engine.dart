import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';

int main() {
  Map<String, Object> testMap = {
    'name': 'lt',
    'returnType': 'boolean',
    'data': [
      {'dtype': 'str', 'str': 'aa'},
      {'dtype': 'str', 'str': 'ac'},
    ]
  };
  Expression expression = Expression.fromMap(testMap);
  print(expression.toString());
  ExpressionEvaluation eval = ExpressionEvaluation();
  bool m = eval.evalExpression(expression);
  print(m);
  return 0;
}

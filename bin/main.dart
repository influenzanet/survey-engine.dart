import 'package:survey_engine.dart/src/models/expression/expression.dart';

int main() {
  var testMap = {
    'name': 'or',
    'returnType': 'int',
    'data': [
      {'dType': 'number', 'number': 1},
      {'dType': 'str', 'str': 'Hello'},
    ]
  };
  Expression expression = Expression.fromMap(testMap);
  print(expression.toString());
  return 0;
}

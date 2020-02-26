import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg_dtype.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';
import 'package:test/test.dart';

void main() {
  group('Localised object creation init tests:\n', () {
    List<ExpressionArg> testExprArgArray;
    Map<String, dynamic> testObjectMap;
    ExpressionArg exprArg;

    setUp(() {
      testObjectMap = {
        'code': 'de',
        'parts': [
          {
            'str':
                'Fachkraft (z.B. Manager, Arzt, Lehrer, Krankenschwester, Ingenieur)'
          },
        ]
      };
    });

    test('Testing a JSON in absence of dType', () {
      exprArg = ExpressionArg(
          dType: ExpressionArgDType(dataType: 'str'),
          str:
              'Fachkraft (z.B. Manager, Arzt, Lehrer, Krankenschwester, Ingenieur)');
      testExprArgArray = [exprArg];
      LocalizedObject expected = LocalizedObject.fromMap(testObjectMap);
      LocalizedObject actual =
          LocalizedObject(code: 'de', parts: testExprArgArray);
      expect(actual.toJson(), expected.toJson());
    });
  });
}

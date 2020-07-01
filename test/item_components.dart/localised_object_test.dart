import 'package:influenzanet_survey_engine/src/controller/utils.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression_arg.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression_arg_dtype.dart';
import 'package:influenzanet_survey_engine/src/models/localized_object/localized_string.dart';
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

    test('Testing a JSON in absence of dtype', () {
      exprArg = ExpressionArg(
          exprArgDType: ExpressionArgDType(dtype: 'str'),
          str:
              'Fachkraft (z.B. Manager, Arzt, Lehrer, Krankenschwester, Ingenieur)');
      testExprArgArray = [exprArg];
      LocalizedString expected = LocalizedString.fromMap(testObjectMap);
      LocalizedString actual =
          LocalizedString(code: 'de', parts: testExprArgArray);
      expect(actual.toJson(), expected.toJson());
    });

    test('An `exp` of return type other than string should typeCast as string',
        () {
      testObjectMap = {
        'code': 'de',
        'parts': [
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
          },
        ]
      };
      LocalizedString localizedObject = LocalizedString.fromMap(testObjectMap);
      expect(Utils.getResolvedLocalisedObject(localizedObject), {
        'code': 'de',
        'parts': [
          "true",
        ]
      });
    });
  });

  group('Localised string evaluation tests:\n', () {
    Map<String, dynamic> testObjectMap;

    setUp(() {
      testObjectMap = {
        'code': 'de',
        'parts': [
          {'str': 'Hello'},
          {'str': 'World'},
        ]
      };
    });

    test(
        'Evaluate parts containing a list of expression strings to list of strings',
        () {
      LocalizedString localizedObject = LocalizedString.fromMap(testObjectMap);
      expect(Utils.getResolvedLocalisedObject(localizedObject), {
        'code': 'de',
        'parts': ['Hello', 'World']
      });
    });
  });
}

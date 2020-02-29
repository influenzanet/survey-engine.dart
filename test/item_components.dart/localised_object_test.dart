import 'package:survey_engine.dart/src/controller/localised_strings.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
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

    test('An `exp` of return type other than string should typeCast as string',
        () {
      testObjectMap = {
        'code': 'de',
        'parts': [
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
          },
        ]
      };
      LocalizedObject localizedObject = LocalizedObject.fromMap(testObjectMap);
      expect(localizedObject.parts[firstArgument].str, 'true');
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

    test('Evaluate parts containing a list of strings to one string', () {
      LocalizedObject localizedObject = LocalizedObject.fromMap(testObjectMap);
      expect(LocalisedString.getLocalisedString(localizedObject), 'HelloWorld');
    });
  });
}
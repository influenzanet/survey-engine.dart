import 'package:survey_engine.dart/src/controller/engine_core.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg_dtype.dart';
import 'package:survey_engine.dart/src/models/item_component/item_group_component.dart';
import 'package:survey_engine.dart/src/models/item_component/properties.dart';
import 'package:test/test.dart';

void main() {
  group('Resolve Component properties test:\n', () {
    Map<String, Map<String, Object>> testProperties;
    setUp(() {
      testProperties = {
        'min': {
          'dtype': 'num',
          'num': -5,
        },
        'max': {
          'dtype': 'num',
          'num': 5,
        },
        'stepSize': {
          'dtype': 'num',
          'num': 5,
        }
      };
    });
    test('Test Properties object creation', () {
      Properties actual = Properties.fromMap(testProperties);
      Properties expected = Properties(
          min: ExpressionArg(
              exprArgDType: ExpressionArgDType(dtype: 'num'), number: -5),
          max: ExpressionArg(
              exprArgDType: ExpressionArgDType(dtype: 'num'), number: 5),
          stepSize: ExpressionArg(
              exprArgDType: ExpressionArgDType(dtype: 'num'), number: 5));
      expect(actual.toJson(), expected.toJson());
    });

    test(
        'Test values of min,max and stepSize on resolving the Component properties',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      Properties sampleProps = Properties.fromMap(testProperties);
      Map<Object, Object> resolvedProps =
          surveyEngineCore.resolveItemComponentProperties(sampleProps);
      expect(resolvedProps['min'], -5);
      expect(resolvedProps['max'], 5);
      expect(resolvedProps['stepSize'], 5);
    });

    // TO DO: write a test for `exp` type once the engine rendered script is complete
  });

  group('Resolve ItemGroupComponent elements:\n', () {
    Map<String, Object> testItemGroupComponentMap;
    setUp(() {
      testItemGroupComponentMap = {
        'role': 'root',
        'items': [
          {
            'role': 'input',
            'displayCondition': {
              'name': 'not',
              'returnType': 'boolean',
              'data': [
                {'dtype': 'num', 'num': 2}
              ]
            },
            'content': [
              {
                'code': 'en',
                'parts': [
                  {'str': 'Some input data'},
                ]
              },
            ],
            'disabled': {
              'name': 'not',
              'returnType': 'boolean',
              'data': [
                {'dtype': 'num', 'num': 2}
              ]
            },
            'key': '4',
            'dtype': 'string',
            'properties': {
              'min': {
                'dtype': 'num',
                'num': -5,
              }
            }
          },
        ]
      };
    });
    test(
        'Test resolve ItemGroup Component with items as a whole object to a Map',
        () {
      // TO DO Order of group components is set to default value and is subject to change
      ItemGroupComponent itemGroupComponent =
          ItemGroupComponent.fromMap(testItemGroupComponentMap);
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      var actual =
          surveyEngineCore.resolveItemComponentGroup(itemGroupComponent);
      Map<String, Object> expected = {
        'role': 'root',
        'items': [
          {
            'role': 'input',
            'displayCondition': false,
            'content': 'Some input data',
            'disabled': false,
            'style': null,
            'key': '4',
            'dtype': 'string',
            'properties': {'min': -5, 'max': null, 'stepSize': null}
          },
        ],
        'order': {'name': 'sequential', 'returnType': 'string', 'data': null}
      };
      expect(actual.toString(), expected.toString());
    });
  });
}

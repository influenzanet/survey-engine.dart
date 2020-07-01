import 'dart:collection';
import 'dart:convert';

import 'package:influenzanet_survey_engine/src/controller/engine_core.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression_arg.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression_arg_dtype.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/item_group_component.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/properties.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_single_item.dart';
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
      dynamic actual =
          surveyEngineCore.resolveItemComponentGroup(itemGroupComponent, null);
      Map<String, Object> expected = {
        'role': 'root',
        'items': [
          {
            'role': 'input',
            'displayCondition': false,
            'content': [
              {
                'code': 'en',
                'parts': ['Some input data']
              },
            ],
            'disabled': false,
            'key': '4',
            'dtype': 'string',
            'properties': {'min': -5}
          },
        ],
        'order': {'name': 'sequential'},
        "displayCondition": true,
        "disabled": false
      };
      expect(json.encode(HashMap.from(actual)),
          json.encode(HashMap.from(expected)));
    });
  });
  group('Resolve SurveySingleItem elements:\n', () {
    Map<String, Object> testSurveySingleItem;
    setUp(() {
      testSurveySingleItem = {
        'key': 'v1',
        'type': 'basic.static.title',
        'validations': [
          {
            'type': 'soft',
            'key': 'v1',
            'rule': {
              'name': 'or',
              'data': [
                {'dtype': 'num', 'num': 2},
                {'dtype': 'num', 'num': 1}
              ]
            }
          },
        ],
        'components': {
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
        }
      };
    });
    test(
        'Test resolve SurveySingleItem Component with items as a whole object to a Map',
        () {
      // TO DO Order of group components is set to default value and is subject to change
      SurveySingleItem surveySingleItem =
          SurveySingleItem.fromMap(testSurveySingleItem);
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      dynamic actual =
          surveyEngineCore.renderSurveySingleItem(surveySingleItem);
      dynamic expected = {
        'key': 'v1',
        'type': 'basic.static.title',
        'components': {
          'role': 'root',
          'items': [
            {
              'role': 'input',
              'displayCondition': false,
              'content': [
                {
                  'code': 'en',
                  'parts': ['Some input data'],
                }
              ],
              'disabled': false,
              'key': '4',
              'dtype': 'string',
              'properties': {'min': -5}
            },
          ],
          'order': {'name': 'sequential'},
          "displayCondition": true,
          "disabled": false
        },
        'validations': [
          {'rule': true, 'type': 'soft', 'key': 'v1'},
        ],
      };
      expect(json.encode(HashMap.from(actual)),
          json.encode(HashMap.from(expected)));
    });
  });
}

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/item_component/item_group_component.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_single_item.dart';
import 'package:survey_engine.dart/src/models/survey_item/validations.dart';
import 'package:test/test.dart';

void main() {
  group('Survey Single item creation init tests:\n', () {
    Map<String, Object> testGroupComponent;
    Map<String, Object> testValidations;

    setUp(() {
      testGroupComponent = {
        "role": "root",
        "items": [
          {
            "role": "title",
            "content": [
              {
                "code": "en",
                "parts": [
                  {
                    "str":
                        "What is the first part of your school/college/workplace postal code (where you spend the majority of your working/studying time)?"
                  }
                ]
              },
              {
                "code": "de",
                "parts": [
                  {"str": "XX"}
                ]
              }
            ]
          }
        ]
      };
      testValidations = {
        'type': 'soft',
        'key': 'v1',
        'rule': {
          'name': 'or',
          'data': [
            {'dtype': 'number', 'number': 2},
            {'dtype': 'number', 'number': 1}
          ]
        }
      };
    });

    test('Testing survey singleItem for every valid itemType:\n', () {
      const List<String> itemTypesTest = [
        'basic.static.title',
        'basic.static.description',
        'basic.input.numeric',
        'basic.input.single-choice',
        'basic.input.multiple-choice',
        'concepts.v1.age.simple-age'
      ];
      print(itemTypesTest);
      Iterable<Map<String, Object>> testSurveySingleList =
          itemTypesTest.map((itemType) => {
                'type': itemType,
                'validations': [
                  {
                    'type': 'soft',
                    'key': 'v1',
                    'rule': {
                      'name': 'or',
                      'data': [
                        {'dtype': 'number', 'number': 2},
                        {'dtype': 'number', 'number': 1}
                      ]
                    }
                  },
                ],
                'components': {
                  "role": "root",
                  "items": [
                    {
                      "role": "title",
                      "content": [
                        {
                          "code": "en",
                          "parts": [
                            {
                              "str":
                                  "What is the first part of your school/college/workplace postal code (where you spend the majority of your working/studying time)?"
                            }
                          ]
                        },
                        {
                          "code": "de",
                          "parts": [
                            {"str": "XX"}
                          ]
                        }
                      ]
                    }
                  ]
                }
              });
      testSurveySingleList.forEach((item) {
        SurveySingleItem expected = SurveySingleItem(
            type: item['type'],
            components: ItemGroupComponent.fromMap(testGroupComponent),
            validation: [Validations.fromMap(testValidations)]);
        SurveySingleItem actual = SurveySingleItem.fromMap(item);
        expect(actual.toJson(), expected.toJson());
      });
    });

    test('Testing an invalid itemType `basic.static.float` throws Exception',
        () {
      Map<String, Object> testSurveySingleItem = {
        'type': 'basic.static.float',
        'validations': [
          {
            'type': 'soft',
            'key': 'v1',
            'rule': {
              'name': 'or',
              'data': [
                {'dtype': 'number', 'number': 2},
                {'dtype': 'number', 'number': 1}
              ]
            }
          },
        ],
        'components': {
          "role": "root",
          "items": [
            {
              "role": "title",
              "content": [
                {
                  "code": "en",
                  "parts": [
                    {
                      "str":
                          "What is the first part of your school/college/workplace postal code (where you spend the majority of your working/studying time)?"
                    }
                  ]
                },
                {
                  "code": "de",
                  "parts": [
                    {"str": "XX"}
                  ]
                }
              ]
            }
          ]
        }
      };
      expect(() => SurveySingleItem.fromMap(testSurveySingleItem),
          throwsA(TypeMatcher<InvalidItemTypeException>()));
    });
  });
}
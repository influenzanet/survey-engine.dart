import 'package:survey_engine.dart/src/models/survey_item/survey_group_item.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_item.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_single_item.dart';
import 'package:test/test.dart';

void main() {
  group('Survey item creation init tests:\n', () {
    Map<String, Object> testSurveySingleItem;
    Map<String, Object> testSurveyGroupItem;

    setUp(() {
      testSurveySingleItem = {
        'key': 'q0',
        'version': 1,
        "condition": {
          'name': 'not',
          'returnType': 'boolean',
          'data': [
            {'dtype': 'str', 'str': ''}
          ]
        },
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
      testSurveyGroupItem = {
        'key': '0',
        'version': 1,
        'items': [
          {
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
          }
        ]
      };
    });

    test(
        'Testing a valid Survey Single Item creation through a Survey item object\n',
        () {
      SurveyItem expected = SurveyItem(testSurveySingleItem);
      SurveySingleItem actual = SurveySingleItem.fromMap(testSurveySingleItem);
      expect(actual.toJson(), expected.toJson());
    });
    test(
        'Testing a valid survey Group Item creation through a Survey item object\n',
        () {
      SurveyItem expected = SurveyItem(testSurveyGroupItem);
      SurveyGroupItem actual = SurveyGroupItem.fromMap(testSurveyGroupItem);
      expect(actual.toJson(), expected.toJson());
    });
  });
}

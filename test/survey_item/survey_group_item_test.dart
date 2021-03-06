import 'package:influenzanet_survey_engine/src/models/survey_item/survey_group_item.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_single_item.dart';
import 'package:test/test.dart';

void main() {
  group('Survey Group item creation init tests:\n', () {
    Map<String, Object> testSurveySingleItem;
    Map<String, Object> testSurveyGroupItem;

    setUp(() {
      testSurveySingleItem = {
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
        'Testing survey Group Item creation having a single Survey Item in items list\n',
        () {
      SurveyGroupItem expected = SurveyGroupItem(
        key: '0',
        version: 1,
        items: [SurveySingleItem.fromMap((testSurveySingleItem))],
      );
      SurveyGroupItem actual = SurveyGroupItem.fromMap(testSurveyGroupItem);
      expect(actual.toJson(), expected.toJson());
    });
  });
}

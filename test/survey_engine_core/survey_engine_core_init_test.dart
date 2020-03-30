import 'dart:convert';

import 'package:survey_engine.dart/src/controller/engine_core.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_group_item.dart';
import 'package:test/test.dart';

void main() {
  // Init group response elements
  group('Resolve SurveyGroup elements:\n', () {
    Map<String, Object> testSurveyGroupItemResult;
    Map<String, Object> testSurveySingleItemOne, testSurveySingleItemTwo;
    setUp(() {
      testSurveySingleItemOne = {
        'key': 'q1',
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
      testSurveySingleItemTwo = {
        'key': 'q2',
        'type': 'basic.static.title',
        'version': 1,
        'validations': [],
        'components': {
          'role': 'root',
          'items': [
            {
              'role': 'title',
              'content': [
                {
                  'code': 'en',
                  'parts': [
                    {'str': 'What is your main activity?'},
                  ]
                },
                {
                  'code': 'de',
                  'parts': [
                    {'str': 'Was ist Ihre Haupttätigkeit?'},
                  ]
                },
              ]
            },
          ]
        }
      };
      testSurveyGroupItemResult = {
        'key': 'res',
        'version': 1,
        'items': [testSurveySingleItemOne, testSurveySingleItemTwo]
      };
    });
    test('Test if responseObjects are created for each survey group item', () {
      Map<String, Object> expected = {
        'key': 'res',
        'meta': {
          'position': -1,
          'localeCode': '',
          'version': 1,
          'rendered': [],
          'displayed': [],
          'responded': [],
        },
        'response': null,
        'items': [
          {
            'key': 'q1',
            'meta': {
              'position': -1,
              'localeCode': '',
              'version': null,
              'rendered': [],
              'displayed': [],
              'responded': [],
            },
            'response': null,
          },
          {
            'key': 'q2',
            'meta': {
              'position': -1,
              'localeCode': '',
              'version': 1,
              'rendered': [],
              'displayed': [],
              'responded': [],
            },
            'response': null,
          }
        ]
      };
      SurveyEngineCore actual = SurveyEngineCore(
          surveyDef: SurveyGroupItem.fromMap(testSurveyGroupItemResult));
      expect(actual.responses.toJson(), json.encode(expected));
    });
  });
}

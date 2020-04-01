import 'dart:convert';

import 'package:survey_engine.dart/src/controller/engine_core.dart';
import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_group_item.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_item_response.dart';
import 'package:test/test.dart';

import 'survey_item_constants.dart';

void main() {
  Map<String, Object> initObject;
  initObject = {
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
      },
      {
        'key': 'grp1',
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
        ]
      }
    ]
  };
  group('Resolve SurveyGroup init survey group item responses:\n', () {
    // Init group response elements
    setUp(() {});
    test('Test if responseObjects are created for each survey group item', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItemResponse actual =
          surveyEngineCore.initSurveyGroupItemResponse(
              SurveyGroupItem.fromMap(testSurveyGroupItemResult));
      expect(actual.toJson(), json.encode(initObject));
    });
    test('Test if responseObjects is null if survey group item is null item',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItemResponse actual =
          surveyEngineCore.initSurveyGroupItemResponse(null);
      expect(actual, isNull);
    });
  });

  group('setTimestamp function tests:\n', () {
    setUp(() {});
    test('Test if responseObjects is null if survey group item is null item',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      timeStampTypes.forEach((timestamp) {
        SurveyGroupItemResponse actual =
            surveyEngineCore.setTimestampFor(timestamp, null);
        expect(actual, isNull);
      });
    });

    test(
        'Test if responseObjects throws exception if invalid timestamp type is passed',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      expect(
          () => surveyEngineCore.setTimestampFor(
              'dummy', SurveyItemResponse(initObject)),
          throwsA(TypeMatcher<InvalidTimestampException>()));
    });

    test(
        'Test if responseObjects throws exception if valid timestamps are appended',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItemResponse actual = surveyEngineCore.setTimestampFor(
          'rendered', SurveyItemResponse(initObject));
      expect(actual.meta.rendered[firstArgument], isNotNull);
      actual = surveyEngineCore.setTimestampFor(
          'displayed', SurveyItemResponse(initObject));
      expect(actual.meta.displayed[firstArgument], isNotNull);
      actual = surveyEngineCore.setTimestampFor(
          'responded', SurveyItemResponse(initObject));
      expect(actual.meta.responded[firstArgument], isNotNull);
    });
  });
}

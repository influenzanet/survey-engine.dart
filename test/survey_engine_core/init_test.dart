import 'dart:convert';

import 'package:survey_engine.dart/src/controller/engine_core.dart';
import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_group_item.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_item_response.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_single_item_response.dart';
import 'package:test/test.dart';

import 'survey_item_constants.dart';

void main() {
  Map<String, Object> initObject;
  initObject = {
    'key': 'G0',
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
        'key': 'G0.S1',
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
        'key': 'G0.S2',
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
        'key': 'G0.G1',
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
            'key': 'G0.G1.S3',
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
              SurveyGroupItem.fromMap(testSurveyGroupItemRoot));
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

  group('Find a Response Item for a particular item key tests:\n', () {
    setUp(() {
      print('Root=' + testSurveyGroupItemRoot.toString());
    });
    test('Test for a null key returns null', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItemResponse actual = surveyEngineCore.findResponseItem(null);
      expect(actual, isNull);
    });

    test('Test if a root object is returned on root SurveyGroupResponse key G0',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItemResponse expected =
          SurveyGroupItemResponse.fromMap(testSurveyGroupItemResponseRoot);
      SurveyGroupItemResponse actual =
          surveyEngineCore.findResponseItem('G0', rootResponseItem: expected);
      print('Actual =' + actual.toJson());
      expect(actual.toJson(), expected.toJson());
    });
    test(
        'Test if a single response object is returned appropriately when searched for G0.G1.S1',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveySingleItemResponse expected =
          SurveySingleItemResponse.fromMap(testSurveySingleItemResponseOne);
      SurveySingleItemResponse actual = surveyEngineCore
          .findResponseItem('G0.G1.S1', rootResponseItem: expected);
      print('Actual =' + actual.toJson());
      expect(actual.toJson(), expected.toJson());
    });

    test(
        'Test if a group response object is returned appropriately when searched for G0.G1',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItemResponse expected =
          SurveyGroupItemResponse.fromMap(testSurveyGroupItemResponseOne);
      SurveyGroupItemResponse actual = surveyEngineCore
          .findResponseItem('G0.G1', rootResponseItem: expected);
      print('Actual =' + actual.toJson());
      expect(actual.toJson(), expected.toJson());
    });

    test(
        'Test if a single nested response object is returned appropriately when searched for G0.G1.S3',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveySingleItemResponse expected =
          SurveySingleItemResponse.fromMap(testSurveySingleItemResponseThree);
      SurveySingleItemResponse actual = surveyEngineCore
          .findResponseItem('G0.G1.S3', rootResponseItem: expected);
      print('Actual =' + actual.toJson());
      expect(actual.toJson(), expected.toJson());
    });
  });
}

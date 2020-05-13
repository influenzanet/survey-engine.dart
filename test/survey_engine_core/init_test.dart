import 'dart:collection';
import 'dart:convert';

import 'package:survey_engine.dart/src/controller/engine_core.dart';
import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_group_item.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_single_item.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_item_response.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_single_item_response.dart';
import 'package:test/test.dart';

import 'survey_item_constants.dart';

void main() {
  group('Resolve SurveyGroup init survey group item responses:\n', () {
    // Init group response elements
    setUp(() {});
    test('Test if responseObjects are created for each survey group item', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItemResponse actual =
          surveyEngineCore.initSurveyGroupItemResponse(
              SurveyGroupItem.fromMap(testSurveyGroupItemRoot));
      expect(actual.toJson(),
          json.encode(HashMap.from(testSurveyGroupItemResponseRoot)));
      // Rendered sets different timestamp at different intervals so only a root level check is
      // expect(actual.toMap().keys, testSurveyGroupItemResponseRoot.keys);
      // expect(actual.toMap()['meta']['rendered'], isNotNull);
      // expect(actual.toMap()['meta']['rendered'], isNotEmpty);
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
              'dummy', SurveyItemResponse(testSurveyGroupItemResponseRoot)),
          throwsA(TypeMatcher<InvalidTimestampException>()));
    });

    test('Test for different kinds of timestamps creation in response item',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItemResponse actual = surveyEngineCore.setTimestampFor(
          'rendered', SurveyItemResponse(testSurveyGroupItemResponseRoot));
      expect(actual.meta.rendered[firstArgument], isNotNull);
      actual = surveyEngineCore.setTimestampFor(
          'displayed', SurveyItemResponse(testSurveyGroupItemResponseRoot));
      expect(actual.meta.displayed[firstArgument], isNotNull);
      actual = surveyEngineCore.setTimestampFor(
          'responded', SurveyItemResponse(testSurveyGroupItemResponseRoot));
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

    test('Test for invalid keys G5, G0.G5 throws warning', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItemResponse expected =
          SurveyGroupItemResponse.fromMap(testSurveyGroupItemRoot);
      expect(
          surveyEngineCore.findResponseItem('G5', rootResponseItem: expected),
          isNull);
      expect(
          surveyEngineCore.findResponseItem('G0.G5',
              rootResponseItem: expected),
          isNull);
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

  group('Find a  Survey Item for a particular item key tests:\n', () {
    setUp(() {
      print('Root=' + testSurveyGroupItemRoot.toString());
    });
    test('Test for a null key returns null', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItem actual = surveyEngineCore.findSurveyItem(null);
      expect(actual, isNull);
    });

    test('Test if invalid keys G5, G0.G5 throws warning', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItem expected =
          SurveyGroupItem.fromMap(testSurveyGroupItemRoot);
      expect(surveyEngineCore.findSurveyItem('G5', rootItem: expected), isNull);
      expect(
          surveyEngineCore.findSurveyItem('G0.G5', rootItem: expected), isNull);
    });
    test('Test if a root object is returned on root SurveyGroup key G0', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItem expected =
          SurveyGroupItem.fromMap(testSurveyGroupItemRoot);
      SurveyGroupItem actual =
          surveyEngineCore.findSurveyItem('G0', rootItem: expected);
      print('Actual =' + actual.toJson());
      expect(actual.toJson(), expected.toJson());
    });
    test(
        'Test if a single survey object is returned appropriately when searched for G0.G1.S1',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveySingleItem expected =
          SurveySingleItem.fromMap(testSurveySingleItemOne);
      SurveySingleItem actual =
          surveyEngineCore.findSurveyItem('G0.G1.S1', rootItem: expected);
      print('Actual =' + actual.toJson());
      expect(actual.toJson(), expected.toJson());
    });

    test(
        'Test if a group survey object is returned appropriately when searched for G0.G1',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItem expected =
          SurveyGroupItem.fromMap(testSurveyGroupItemOne);
      //print(surveyEngineCore.initRenderedGroupItem(expected).toString());
      SurveyGroupItem actual =
          surveyEngineCore.findSurveyItem('G0.G1', rootItem: expected);
      print('Actual =' + actual.toJson());
      expect(actual.toJson(), expected.toJson());
    });

    test(
        'Test if a single nested survey object is returned appropriately when searched for G0.G1.S3',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveySingleItem expected =
          SurveySingleItem.fromMap(testSurveySingleItemThree);
      SurveySingleItem actual =
          surveyEngineCore.findSurveyItem('G0.G1.S3', rootItem: expected);
      print('Actual =' + actual.toJson());
      expect(actual.toJson(), expected.toJson());
    });
  });
  group('Init Survey Group test:\n', () {
    setUp(() {
      print('Expected=' + renderedSurveyGroupRoot.toString());
    });
    test('Test if Group root G0 is rendered succesfully', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore(
          surveyDef: SurveyGroupItem.fromMap(testSurveyGroupItemRoot));
      dynamic actualMap = surveyEngineCore.initRenderedGroupItem(
          SurveyGroupItem.fromMap(testSurveyGroupItemRoot));
      dynamic actual = surveyEngineCore.getRenderedSurvey();
      dynamic expected = renderedSurveyGroupRoot;
      expect(json.encode((actual)), json.encode((expected)));
    });
  });
}

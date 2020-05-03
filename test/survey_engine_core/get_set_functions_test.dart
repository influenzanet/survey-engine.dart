import 'dart:convert';

import 'package:survey_engine.dart/src/controller/engine_core.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_group_item.dart';
import 'package:test/test.dart';

import 'survey_item_constants.dart';

void main() {
  group('Test getter functions to be exposed to frontend:\n', () {
    setUp(() {});
    test('Test if survey G0 is rendered succesfully (getRenderedSurvey)', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore(
          surveyDef: SurveyGroupItem.fromMap(testSurveyGroupItemRoot));
      dynamic expected = renderedSurveyGroupRoot;

      dynamic actual = surveyEngineCore.getRenderedSurvey();
      expect(json.encode(actual), json.encode(expected));
    });

    test('Test if a root response tree is flattened', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore(
          surveyDef: SurveyGroupItem.fromMap(testSurveyGroupItemRoot));
      dynamic actual = surveyEngineCore.getResponses();
      dynamic expected = flatResponseItems;
      // Since timestamps are punched in responses,
      // an exact expected response list cannot be determined.
      // Therefore, only the key and lenth of the array is checked
      expect(actual.length, expected.length);
      expect(actual[rootItem]['key'], expected[rootItem]['key']);
      expect(actual[firstItem]['key'], expected[firstItem]['key']);
      expect(actual[secondItem]['key'], expected[secondItem]['key']);
    });
  });
}

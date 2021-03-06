import 'dart:collection';
import 'dart:convert';

import 'package:influenzanet_survey_engine/api/api.dart';
import 'package:test/test.dart';

import 'survey_item_constants.dart';

void main() {
  group('Test getter functions to be exposed to frontend:\n', () {
    setUp(() {});
    test('Test if survey G0 is rendered succesfully (getRenderedSurvey)', () {
      SurveyEngineCoreApi surveyEngineCore = SurveyEngineCoreApi(
          surveyDef: SurveyGroupItem.fromMap(testSurveyGroupItemRoot));
      dynamic expected = renderedSurveyGroupRoot;

      dynamic actual = surveyEngineCore.getRenderedSurvey();
      expect(json.encode(HashMap.from(actual)),
          json.encode(HashMap.from(expected)));
    });

    test('Test if a root response tree is flattened', () {
      SurveyEngineCoreApi surveyEngineCore = SurveyEngineCoreApi(
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

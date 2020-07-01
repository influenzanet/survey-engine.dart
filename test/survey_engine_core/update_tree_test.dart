import 'package:influenzanet_survey_engine/src/controller/engine_core.dart';
import 'package:influenzanet_survey_engine/src/models/constants.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item_response/survey_single_item_response.dart';
import 'package:test/test.dart';

import 'survey_item_constants.dart';

void main() {
  group('Update a Response Item in a response item group:\n', () {
    setUp(() {
      print('Root=' + testSurveyGroupItemRoot.toString());
    });
    test('Test for a null key returns null', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItemResponse actual = surveyEngineCore.updateResponseItem();
      expect(actual, isNull);
    });

    test('Test if a root object is updated on root SurveyGroupResponse key G0',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItemResponse expected =
          SurveyGroupItemResponse.fromMap(testSurveyGroupItemResponseRoot);
      SurveyGroupItemResponse actual = surveyEngineCore.updateResponseItem(
          responseGroup: expected, changeKey: 'G0', timeStampType: 'rendered');
      expected =
          SurveyGroupItemResponse.fromMap(testSurveyGroupItemResponseRoot);
      expect(actual.key, expected.key);
      expect(actual.items.toString(), expected.items.toString());
      expect(actual.meta.rendered.length > 0, isTrue);
    });

    test(
        'Test if a single nested response object is returned appropriately when searched for G0.G1.S3',
        () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItemResponse root =
          SurveyGroupItemResponse.fromMap(testSurveyGroupItemResponseRoot);
      SurveyGroupItemResponse updatedRoot = surveyEngineCore.updateResponseItem(
          responseGroup: root,
          changeKey: 'G0.G1.S3',
          timeStampType: 'rendered');
      SurveySingleItemResponse expected =
          SurveySingleItemResponse.fromMap(testSurveySingleItemThree);
      var actual = updatedRoot.items[secondItem].items[firstArgument];
      print('Actual =' + updatedRoot.toJson());
      expect(actual.key, expected.key);
      expect(actual.items.toString(), expected.items.toString());
      expect(actual.meta.rendered.length > 0, isTrue);
    });
  });
}

import 'package:survey_engine.dart/src/controller/engine_core.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_group_item.dart';
import 'package:test/test.dart';

import 'survey_item_constants.dart';

void main() {
  group('Helper function tests:\n', () {
    // Init group response elements
    setUp(() {});

    test('Follow up and non follow up items null tests ', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      expect(surveyEngineCore.getFollowUpItems(null, 'G0'), isNull);
      expect(surveyEngineCore.getItemsWithoutFollows(null, 'G0'), isNull);
    });
    test('Follow up items of G0 returns G1', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItem expected =
          SurveyGroupItem.fromMap(testSurveyGroupItemRoot);
      dynamic actual =
          surveyEngineCore.getFollowUpItems(expected, expected.key);
      expect(actual[firstArgument]['key'] == 'G0.S1', isTrue);
    });
    test('Non Follow up items of G0 returns S2 and G0.G1', () {
      SurveyEngineCore surveyEngineCore = SurveyEngineCore();
      SurveyGroupItem expected =
          SurveyGroupItem.fromMap(testSurveyGroupItemRoot);
      dynamic actual =
          surveyEngineCore.getItemsWithoutFollows(expected, expected.key);
      expect(actual[firstArgument]['key'] == 'G0.S2', isTrue);
      expect(actual[secondArgument]['key'] == 'G0.G1', isTrue);
    });
  });
}

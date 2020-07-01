import 'dart:convert';

import 'package:influenzanet_survey_engine/api/api.dart';
import 'package:influenzanet_survey_engine/src/controller/engine_core.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_group_item.dart';
import 'package:test/test.dart';

import 'qp4.dart';

void main() {
  group('Testing a live survey question based on set Response Items:\n', () {
    SurveyGroupItem inputSurvey;
    setUp(() {
      inputSurvey = SurveyGroupItem.fromMap(qp4);
      print("Input Survey=\n");
      print(inputSurvey.toJson());
    });

    test('Testing first render with no item response set\n', () {
      SurveyEngineCore surveyEngineCore =
          SurveyEngineCore(surveyDef: inputSurvey);
      dynamic rendered = surveyEngineCore.getRenderedSurvey();
      print("Rendered Survey=\n");
      print(json.encode(rendered));
      surveyEngineCore.questionDisplayed('QG0.QG4.Q4');

      expect(rendered['items'][firstArgument]['items'].length, 1);
      expect(rendered['items'][firstArgument]['items'][firstArgument]['key'],
          'QG0.QG4.Q4');
    });

    test(
        'Testing render with an item response set for Q4 returns two more new questions\n',
        () {
      SurveyEngineCore surveyEngineCore =
          SurveyEngineCore(surveyDef: inputSurvey);

      surveyEngineCore.questionDisplayed('QG0.QG4.Q4');
      surveyEngineCore.setResponse(
          key: 'QG0.QG4.Q4',
          response: ResponseItem.fromMap({
            'key': 'RG1',
            'items': [
              {
                'key': 'RG1.R1',
                'value': "14",
                'dtype': 'number',
              }
            ],
          }));

      dynamic rendered = surveyEngineCore.getRenderedSurvey();
      print("Rendered Survey=\n");
      print(json.encode(rendered));
      expect(rendered['items'][firstArgument]['items'].length, 3);
      expect(rendered['items'][firstArgument]['items'][firstArgument]['key'],
          'QG0.QG4.Q4');
      expect(rendered['items'][firstArgument]['items'][secondArgument]['key'],
          'QG0.QG4.Q4b');
      expect(rendered['items'][firstArgument]['items'][thirdArgument]['key'],
          'QG0.QG4.Q4c');
    });
  });
}

import 'dart:convert';

import 'package:survey_engine.dart/src/controller/engine_core.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_group_item.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/response_item.dart';
import 'package:test/test.dart';

import 'qp.dart';

void main() {
  group('Testing set response on a survey group from web client', () {
    SurveyGroupItem inputSurvey;
    setUp(() {
      inputSurvey = SurveyGroupItem.fromMap(qp);
      print("Unrendered Survey=\n" + inputSurvey.toJson());
    });
    test(
        'Testing first render displays three questions with no responses set\n',
        () {
      SurveyEngineCore surveyEngineCore =
          SurveyEngineCore(surveyDef: inputSurvey, weedRemoval: true);
      dynamic rendered = surveyEngineCore.getRenderedSurvey();
      print(json.encode(rendered));
      expect(rendered['items'].length, 3);
      expect(rendered['items'][firstArgument]['key'], '0.4');
      expect(rendered['items'][secondArgument]['key'], '0.5');
      expect(rendered['items'][thirdArgument]['key'], '0.6');
      expect(rendered['items'][firstArgument]['items'].length, 1);
      expect(rendered['items'][firstArgument]['items'][firstArgument]['key'],
          '0.4.4');
    });

    test(
        'Testing the render changes when a response is set for a question 0.4.4 \n',
        () {
      SurveyEngineCore surveyEngineCore =
          SurveyEngineCore(surveyDef: inputSurvey, weedRemoval: true);

      surveyEngineCore.setResponse(
          key: '0.4.4',
          response: ResponseItem.fromMap({
            'key': '1',
            'items': [
              {
                'key': '1.1',
                'items': [
                  {
                    'key': '1.1.1',
                  },
                ]
              }
            ],
          }));
      dynamic rendered = surveyEngineCore.getRenderedSurvey();
      print(json.encode(rendered));
      // Note the change in length of the survey length 0.4.4b and 0.4.4c are added
      expect(rendered['items'][firstArgument]['items'].length, 3);

      surveyEngineCore.setResponse(
          key: '0.4.4',
          response: ResponseItem.fromMap({
            'key': '1',
            'items': [
              {
                'key': '1.1',
                'items': [
                  {
                    'key': '1.1.0',
                  },
                ]
              }
            ],
          }));
      rendered = surveyEngineCore.getRenderedSurvey();
      expect(rendered['items'].length, 3);
      expect(rendered['items'][firstArgument]['key'], '0.4');
      expect(rendered['items'][secondArgument]['key'], '0.5');
      expect(rendered['items'][thirdArgument]['key'], '0.6');
      expect(rendered['items'][firstArgument]['items'][firstArgument]['key'],
          '0.4.4');
      // Note the change in length of the survey length 0.4.4b and 0.4.4c are removed
      expect(rendered['items'][firstArgument]['items'].length, 1);
    });
  });
}

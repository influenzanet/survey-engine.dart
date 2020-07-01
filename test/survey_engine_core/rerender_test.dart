import 'dart:convert';
import 'dart:io';

import 'package:influenzanet_survey_engine/src/controller/engine_core.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_group_item.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item_response/response_item.dart';
import 'package:test/test.dart';

import '../survey_engine_core/qp4.dart';

void main() {
  group('Rerendering tests on setting a response item:\n', () {
    setUp(() {});
    test(
        'Testing rerendering on set responses changing dsplay conditions of item components\n',
        () {
      SurveyGroupItem actual = SurveyGroupItem.fromMap(qp);
      SurveyEngineCore surveyEngineCore =
          SurveyEngineCore(surveyDef: actual, weedRemoval: true);
      dynamic rendered = surveyEngineCore.getRenderedSurvey();
      var out =
          new File('lib/src/test_json/web_client_output/first_rendered.json')
              .openWrite();
      out.write(json.encode(rendered));
      out.close();
      surveyEngineCore.setResponse(
          key: '0.5.5',
          response: ResponseItem.fromMap({
            'key': '1',
            'items': [
              {
                'key': '1.1',
                'items': [
                  {
                    'key': '1.1.3',
                  },
                  {
                    'key': '1.1.2',
                  },
                  {
                    'key': '1.1.1',
                  },
                ]
              }
            ],
          }));

      dynamic newRendered = surveyEngineCore.getRenderedSurvey();
      out = new File(
              'lib/src/test_json/web_client_output/set_three_test_display_condition.json')
          .openWrite();
      out.write(json.encode(newRendered));
      out.close();

      surveyEngineCore.setResponse(
          key: '0.5.5',
          response: ResponseItem.fromMap({
            'key': '1',
            'items': [
              {
                'key': '1.1',
                'items': [
                  {
                    'key': '1.1.5',
                  },
                  {
                    'key': '1.1.4',
                  },
                  {
                    'key': '1.1.3',
                  },
                  {
                    'key': '1.1.2',
                  },
                  {
                    'key': '1.1.1',
                  },
                ]
              }
            ],
          }));
      newRendered = surveyEngineCore.getRenderedSurvey();
      out = new File(
              'lib/src/test_json/web_client_output/set_all_test_display_condition.json')
          .openWrite();
      out.write(json.encode(newRendered));
      out.close();
      print(json.encode(newRendered));

      out = new File(
              'lib/src/test_json/web_client_output/flatRenderedSurvey.json')
          .openWrite();
      out.write(json.encode(surveyEngineCore.flattenSurveyItemtree()));
      out.close();
    });
  });
}

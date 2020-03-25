import 'package:survey_engine.dart/src/models/survey_item_response/responseItem.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/responseMeta.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/surveyGroupItemResponse.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/surveyItemResponse.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/surveySingleItemResponse.dart';
import 'package:test/test.dart';

void main() {
  group('Survey single and group Item object creation tests:\n', () {
    Map<String, Object> testSurveySingleItemResponse;
    ResponseMeta responseMeta;
    ResponseItem item, responseItem;
    setUp(() {
      responseMeta = ResponseMeta(
          position: 1,
          localeCode: 'someCode',
          version: 1,
          rendered: [1, 2],
          displayed: [1, 2],
          responded: [1, 2]);
      item = ResponseItem(key: 'RG1.R1', value: "something", dtype: 'str');
      responseItem =
          ResponseItem(dtype: 'num', items: [item], key: 'RG1', value: '14');

      testSurveySingleItemResponse = {
        'key': 'SR1',
        'meta': {
          'position': 1,
          'localeCode': 'someCode',
          'version': 1,
          'rendered': [1, 2],
          'displayed': [1, 2],
          'responded': [1, 2]
        },
        'response': {
          'key': 'RG1',
          'items': [
            {'key': 'RG1.R1', 'value': "something", 'dtype': 'str'}
          ],
          'value': "14",
          'dtype': 'num',
        }
      };
    });

    test('Test Survey single Item object creation from Map :\n', () {
      // TO DO: Write test for a valid timestamp after string conversion clarification
      SurveySingleItemResponse expected = SurveySingleItemResponse(
          key: 'SR1', meta: responseMeta, response: responseItem);
      SurveySingleItemResponse actual =
          SurveySingleItemResponse.fromMap(testSurveySingleItemResponse);
      print('Expected = $expected \n Actual = $actual');
      expect(actual.toJson(), expected.toJson());
    });

    test('Test Survey group item object creation from Map :\n', () {
      // TO DO: Write test for a valid timestamp after string conversion clarification
      SurveyGroupItemResponse expected = SurveyGroupItemResponse(items: [
        SurveySingleItemResponse.fromMap(testSurveySingleItemResponse)
      ]);

      SurveyGroupItemResponse actual = SurveyGroupItemResponse.fromMap({
        'items': [testSurveySingleItemResponse]
      });
      print('Expected = $expected \n Actual = $actual');
      expect(actual.toJson(), expected.toJson());
    });

    test(
        'Test Survey single Item object creation through survey item interface :\n',
        () {
      // TO DO: Write test for a valid timestamp after string conversion clarification
      SurveyItemResponse expected =
          SurveyItemResponse(testSurveySingleItemResponse);
      SurveySingleItemResponse actual =
          SurveySingleItemResponse.fromMap(testSurveySingleItemResponse);
      print('Expected = $expected \n Actual = $actual');
      expect(actual.toJson(), expected.toJson());
    });

    test(
        'Test Survey group Item object creation through survey item interface :\n',
        () {
      // TO DO: Write test for a valid timestamp after string conversion clarification
      SurveyItemResponse expected = SurveyItemResponse({
        'items': [testSurveySingleItemResponse]
      });
      SurveyGroupItemResponse actual = SurveyGroupItemResponse.fromMap({
        'items': [testSurveySingleItemResponse]
      });
      print('Expected = $expected \n Actual = $actual');
      expect(actual.toJson(), expected.toJson());
    });
  });
}

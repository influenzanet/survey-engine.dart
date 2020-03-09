import 'package:survey_engine.dart/src/models/survey_item_response/responseItem.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/responseMeta.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/surveyGroupItemResponse.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/surveySingleItemResponse.dart';

abstract class SurveyItemResponse {
  String key;
  ResponseMeta meta;
  ResponseItem response;
  List<SurveyItemResponse> items;
  factory SurveyItemResponse(Map<String, dynamic> map) {
    if (map['items'] == null) {
      return SurveySingleItemResponse.fromMap(map);
    } else {
      return SurveyGroupItemResponse.fromMap(map);
    }
  }

  String toString();
  Map<String, dynamic> toMap();
}

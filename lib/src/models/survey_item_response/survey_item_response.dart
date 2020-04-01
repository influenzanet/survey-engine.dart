import 'package:survey_engine.dart/src/models/survey_item_response/response_item.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/response_meta.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_single_item_response.dart';

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
  String toJson();
}

import 'dart:convert';

import 'package:survey_engine.dart/src/models/survey_item_response/responseItem.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/responseMeta.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/surveyItemResponse.dart';

class SurveySingleItemResponse implements SurveyItemResponse {
  ResponseItem response;
  List<SurveyItemResponse> items;
  String key;
  ResponseMeta meta;
  SurveySingleItemResponse({
    this.response,
    this.key,
    this.meta,
  });

  Map<String, dynamic> toMap() {
    return {
      'response': response?.toMap(),
      'key': key,
      'meta': meta.toMap(),
    };
  }

  static SurveySingleItemResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SurveySingleItemResponse(
      response: ResponseItem?.fromMap(map['response']),
      key: map['key'],
      meta: ResponseMeta?.fromMap(map['meta']),
    );
  }

  String toJson() => json.encode(toMap());

  static SurveySingleItemResponse fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'SurveySingleItemResponse(response: $response, key: $key, meta: $meta)';
  }
}

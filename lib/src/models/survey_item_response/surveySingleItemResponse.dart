import 'dart:convert';

import 'package:survey_engine.dart/src/controller/utils.dart';
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
    this.items,
    this.key,
    this.meta,
  });

  Map<String, dynamic> toMap() {
    return {
      'response': response.toMap(),
      'items': Utils.resolveNullList(items),
      'key': key,
      'meta': meta.toMap(),
    };
  }

  static SurveySingleItemResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SurveySingleItemResponse(
      response: ResponseItem.fromMap(map['response']),
      items: List<SurveyItemResponse>.from(
          map['items']?.map((x) => SurveyItemResponse(x))),
      key: map['key'],
      meta: ResponseMeta.fromMap(map['meta']),
    );
  }

  String toJson() => json.encode(toMap());

  static SurveySingleItemResponse fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'SurveySingleItemResponse(response: $response, items: $items, key: $key, meta: $meta)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SurveySingleItemResponse &&
        o.response == response &&
        o.items == items &&
        o.key == key &&
        o.meta == meta;
  }

  @override
  int get hashCode {
    return response.hashCode ^ items.hashCode ^ key.hashCode ^ meta.hashCode;
  }
}

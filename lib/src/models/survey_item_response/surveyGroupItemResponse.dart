import 'dart:convert';

import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/responseItem.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/responseMeta.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/surveyItemResponse.dart';

class SurveyGroupItemResponse implements SurveyItemResponse {
  List<SurveyItemResponse> items;
  String key;
  ResponseMeta meta;
  ResponseItem response;
  SurveyGroupItemResponse({
    this.items,
    this.key,
    this.meta,
    this.response,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'meta': meta?.toMap(),
      'response': response?.toMap(),
      'items': Utils.resolveNullListOfMaps(items),
    };
  }

  static SurveyGroupItemResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    var temp = map['items']?.map((x) => SurveyItemResponse(x));
    var tempData = (temp == null) ? null : List<SurveyItemResponse>.from(temp);
    return SurveyGroupItemResponse(
      items: tempData,
      key: map['key'],
      meta: ResponseMeta.fromMap(map['meta']),
      response: ResponseItem?.fromMap(map['response']),
    );
  }

  String toJson() => json.encode(toMap());

  static SurveyGroupItemResponse fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'SurveyGroupItemResponse(items: $items, key: $key, meta: $meta, response: $response)';
  }
}

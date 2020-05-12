import 'dart:collection';
import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/response_item.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/response_meta.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_item_response.dart';

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
    return Utils.removeNullParams({
      'key': key,
      'meta': meta?.toMap(),
      'response': response?.toMap(),
      'items': Utils.resolveNullListOfMaps(items),
    });
  }

  static SurveyGroupItemResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      var temp = map['items']?.map((x) => SurveyItemResponse(x));
      var tempData =
          (temp == null) ? null : List<SurveyItemResponse>.from(temp);
      return SurveyGroupItemResponse(
        items: tempData,
        key: map['key'],
        meta: ResponseMeta.fromMap(map['meta']),
        response: ResponseItem?.fromMap(map['response']),
      );
    } catch (e) {
      throw MapCreationException(
          className: 'SurveyGroupItemResponse', map: map);
    }
  }

  String toJson() => json.encode(HashMap.from(toMap()));

  static SurveyGroupItemResponse fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'SurveyGroupItemResponse(items: $items, key: $key, meta: $meta, response: $response)';
  }
}

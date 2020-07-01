import 'dart:collection';
import 'dart:convert';

import 'package:influenzanet_survey_engine/src/controller/exceptions.dart';
import 'package:influenzanet_survey_engine/src/controller/utils.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item_response/response_item.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item_response/response_meta.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item_response/survey_item_response.dart';

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
    return Utils.removeNullParams(
        {'key': key, 'meta': meta?.toMap(), 'response': response?.toMap()});
  }

  static SurveySingleItemResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      return SurveySingleItemResponse(
        response: ResponseItem?.fromMap(map['response']),
        key: map['key'],
        meta: ResponseMeta?.fromMap(map['meta']),
      );
    } catch (e) {
      throw MapCreationException(
          className: 'SurveySingleItemResponse', map: map);
    }
  }

  String toJson() => json.encode(HashMap.from(toMap()));

  static SurveySingleItemResponse fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'SurveySingleItemResponse(response: $response, key: $key, meta: $meta)';
  }
}

import 'dart:collection';
import 'dart:convert';

import 'package:influenzanet_survey_engine/src/controller/exceptions.dart';
import 'package:influenzanet_survey_engine/src/controller/utils.dart';

class ResponseMeta {
  int position;
  String localeCode;
  int version;
  List<int> rendered;
  List<int> displayed;
  List<int> responded;
  ResponseMeta(
      {this.position,
      this.localeCode,
      this.version,
      this.rendered,
      this.displayed,
      this.responded}) {
    this.position ??= -1;
    this.localeCode ??= '';
    this.rendered ??= [];
    this.displayed ??= [];
    this.responded ??= [];
  }

  Map<String, dynamic> toMap() {
    return Utils.removeNullParams({
      'position': position,
      'localeCode': localeCode,
      'version': version,
      'rendered': Utils.resolveNullList(rendered),
      'displayed': Utils.resolveNullList(displayed),
      'responded': Utils.resolveNullList(responded),
    });
  }

  static ResponseMeta fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      return ResponseMeta(
        position: map['position'],
        localeCode: map['localeCode'],
        version: map['version'],
        rendered:
            (map['rendered'] == null) ? [] : List<int>.from(map['rendered']),
        displayed:
            (map['displayed'] == null) ? [] : List<int>.from(map['displayed']),
        responded:
            (map['responded'] == null) ? [] : List<int>.from(map['responded']),
      );
    } catch (e) {
      throw MapCreationException(className: 'ResponseMeta', map: map);
    }
  }

  String toJson() => json.encode(HashMap.from(toMap()));

  static ResponseMeta fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResponseMeta(position: $position, localeCode: $localeCode, version: $version, rendered: $rendered, displayed: $displayed, responded: $responded)';
  }
}

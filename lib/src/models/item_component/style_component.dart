import 'dart:convert';

import 'package:survey_engine.dart/src/controller/utils.dart';

class Style {
  String key;
  String value;
  Style({
    this.key,
    this.value,
  });

  Style copyWith({
    String key,
    String value,
  }) {
    return Style(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return Utils.removeNullParams({
      'key': key,
      'value': value,
    });
  }

  static Style fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Style(
      key: map['key'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  static Style fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Style(key: $key, value: $value)';
}

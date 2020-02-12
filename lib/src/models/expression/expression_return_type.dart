import 'dart:convert';

import 'package:survey_engine.dart/src/models/constants.dart';

class ReturnType {
  String dType;
  ReturnType({String dataType = 'boolean'}) {
    if (returnType.contains(dataType)) {
      dType = dataType;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'dType': dType,
    };
  }

  static ReturnType fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ReturnType(
      dataType: map['dType'],
    );
  }

  String toJson() => json.encode(toMap());

  static ReturnType fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => '$dType';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ReturnType && o.dType == dType;
  }

  @override
  int get hashCode => dType.hashCode;
}

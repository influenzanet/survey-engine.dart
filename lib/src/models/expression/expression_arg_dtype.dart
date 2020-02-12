import 'dart:convert';

import 'package:survey_engine.dart/src/models/constants.dart';

class ExpressionArgDType {
  String dType;
  ExpressionArgDType({String dataType = 'str'}) {
    if (expressionArgType.contains(dataType)) {
      dType = dataType;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'dType': dType,
    };
  }

  static ExpressionArgDType fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ExpressionArgDType(
      dataType: map['dType'],
    );
  }

  String toJson() => json.encode(toMap());

  static ExpressionArgDType fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() => '$dType';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ExpressionArgDType && o.dType == dType;
  }

  @override
  int get hashCode => dType.hashCode;
}

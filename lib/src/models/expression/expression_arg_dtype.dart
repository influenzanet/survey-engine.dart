import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/constants.dart';

class ExpressionArgDType {
  String dType;
  ExpressionArgDType({this.dType}) {
    this.dType = this.dType ?? 'str';
    if (!expressionArgType.contains(this.dType)) {
      throw InvalidArgumentsException(message: expressionArgType.toString());
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
      dType: map['dType'],
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

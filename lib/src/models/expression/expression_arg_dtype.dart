import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/constants.dart';

class ExpressionArgDType {
  String dtype;
  ExpressionArgDType({this.dtype}) {
    this.dtype = this.dtype ?? 'str';
    if (!expressionArgType.contains(this.dtype)) {
      throw InvalidArgumentsException(message: expressionArgType.toString());
    }
  }

  Map<String, dynamic> toMap() {
    return Utils.removeNullParams({
      'dtype': dtype,
    });
  }

  static ExpressionArgDType fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      return ExpressionArgDType(
        dtype: map['dtype'],
      );
    } catch (e) {
      throw MapCreationException(className: 'ExpressionArgDType', map: map);
    }
  }

  String toJson() => json.encode(toMap());

  static ExpressionArgDType fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() => '$dtype';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ExpressionArgDType && o.dtype == dtype;
  }

  @override
  int get hashCode => dtype.hashCode;
}

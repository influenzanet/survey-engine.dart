import 'dart:convert';

import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg_dtype.dart';

class LocalizedObject {
  String code;
  List<ExpressionArg> parts;
  LocalizedObject({String code, List<ExpressionArg> parts}) {
    this.code = code;
    // Need to change for `exp` types.
    parts.forEach((f) => f.dType = ExpressionArgDType(dataType: 'str'));
    this.parts = parts;
  }
  // LocalizedMedia needs to be defined

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'parts': List<dynamic>.from(parts.map((x) => x.toMap())),
    };
  }

  static LocalizedObject fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LocalizedObject(
      code: map['code'],
      parts: List<ExpressionArg>.from(
          map['parts']?.map((x) => ExpressionArg.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static LocalizedObject fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() => 'LocalizedObject code: $code, parts: $parts';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LocalizedObject && o.code == code && o.parts == parts;
  }

  @override
  int get hashCode => code.hashCode ^ parts.hashCode;
}

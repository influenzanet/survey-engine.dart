import 'dart:convert';

import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';

class LocalizedObject {
  String code;
  List<ExpressionArg> parts;
  LocalizedObject({String code, List<ExpressionArg> parts}) {
    this.code = code;
    // Localised media needs to be an 'str' only so it is resolved if it has any other datatype
    parts = Utils.resolveParts(parts);
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
    var temp = map['parts']?.map((x) => ExpressionArg.fromMap(x));
    var tempParts = List<ExpressionArg>.from(temp);

    return LocalizedObject(
      code: map['code'],
      parts: tempParts,
    );
  }

  String toJson() => json.encode(toMap());

  static LocalizedObject fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() => 'LocalizedObject code: $code, parts: $parts';
}

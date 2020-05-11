import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';

class LocalizedObject {
  String code;
  List<ExpressionArg> parts;
  LocalizedObject({String code, List<ExpressionArg> parts}) {
    this.code = code;
    this.parts = parts;
  }
  // LocalizedMedia needs to be defined

  Map<String, dynamic> toMap() {
    return Utils.removeNullParams({
      'code': code,
      'parts': Utils.resolveNullListOfMaps(parts),
    });
  }

  static LocalizedObject fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      var temp = map['parts']?.map((x) => ExpressionArg.fromMap(x));
      var tempParts = List<ExpressionArg>.from(temp);

      return LocalizedObject(
        code: map['code'],
        parts: tempParts,
      );
    } catch (e) {
      throw MapCreationException(className: 'LocalisedObject', map: map);
    }
  }

  String toJson() => json.encode(toMap());

  static LocalizedObject fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() => 'LocalizedObject code: $code, parts: $parts';
}

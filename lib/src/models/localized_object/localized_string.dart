import 'dart:collection';
import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';

class LocalizedString implements LocalizedObject {
  String code;
  List<ExpressionArg> parts;
  LocalizedString({String code, List<ExpressionArg> parts}) {
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

  static LocalizedString fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      var temp = map['parts']?.map((x) => ExpressionArg.fromMap(x));
      var tempParts = List<ExpressionArg>.from(temp);

      return LocalizedString(
        code: map['code'],
        parts: tempParts,
      );
    } catch (e) {
      throw MapCreationException(className: 'LocalisedObject', map: map);
    }
  }

  String toJson() => json.encode(HashMap.from(toMap()));

  static LocalizedString fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() => 'LocalizedString code: $code, parts: $parts';
}

import 'dart:collection';
import 'dart:convert';

import 'package:influenzanet_survey_engine/src/controller/exceptions.dart';
import 'package:influenzanet_survey_engine/src/controller/utils.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression_arg.dart';

class Properties {
  ExpressionArg min;
  ExpressionArg max;
  ExpressionArg stepSize;
  Properties({
    this.min,
    this.max,
    this.stepSize,
  });

  Map<String, dynamic> toMap() {
    return Utils.removeNullParams({
      'min': min?.toMap(),
      'max': max?.toMap(),
      'stepSize': stepSize?.toMap(),
    });
  }

  static Properties fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      return Properties(
        min: ExpressionArg.fromMap(map['min']),
        max: ExpressionArg.fromMap(map['max']),
        stepSize: ExpressionArg.fromMap(map['stepSize']),
      );
    } catch (e) {
      throw MapCreationException(className: 'Properties', map: map);
    }
  }

  String toJson() => json.encode(HashMap.from(toMap()));

  static Properties fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Properties min: $min, max: $max, stepSize: $stepSize';
}

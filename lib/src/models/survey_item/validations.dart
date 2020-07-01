import 'dart:collection';
import 'dart:convert';

import 'package:influenzanet_survey_engine/src/controller/exceptions.dart';
import 'package:influenzanet_survey_engine/src/controller/utils.dart';
import 'package:influenzanet_survey_engine/src/models/constants.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';

class Validations {
  Expression rule;
  String type;
  String key;
  Validations({
    this.rule,
    this.type,
    this.key,
  }) {
    rule.returnType = 'boolean';
    if (!validationType.contains(this.type)) {
      throw InvalidValidationException(
          message:
              'Expected validation types in $validationType but got $this.type');
    }
  }

  Map<String, dynamic> toMap() {
    return Utils.removeNullParams({
      'rule': rule.toMap(),
      'type': type,
      'key': key,
    });
  }

  static Validations fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      return Validations(
        rule: Expression.fromMap(map['rule']),
        type: map['type'],
        key: map['key'],
      );
    } catch (e) {
      throw MapCreationException(className: 'Validations', map: map);
    }
  }

  String toJson() => json.encode(HashMap.from(toMap()));

  static Validations fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Validations(rule: $rule, type: $type, key: $key)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Validations && o.rule == rule && o.type == type && o.key == key;
  }

  @override
  int get hashCode => rule.hashCode ^ type.hashCode ^ key.hashCode;
}

import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';

class Validations {
  Expression rule;
  String type;
  String key;
  Validations({
    this.rule,
    this.type,
    this.key,
  }) {
    if (rule.returnType.dType != 'boolean') {
      throw InvalidValidationException(
          message:
              'Expected a return type `boolean` but got $rule.returnType.dType');
    }
    if (!validationType.contains(this.type)) {
      throw InvalidValidationException(
          message:
              'Expected validation types in $validationType but got $this.type');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'rule': rule.toMap(),
      'type': type,
      'key': key,
    };
  }

  static Validations fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Validations(
      rule: Expression.fromMap(map['rule']),
      type: map['type'],
      key: map['key'],
    );
  }

  String toJson() => json.encode(toMap());

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

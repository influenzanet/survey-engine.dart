import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';

class DisplayItemComponent {
  String role;
  Expression displayCondition;
  List<LocalizedObject> content;
  Expression disabled;
  Map<String, String> style;
  String key;
  DisplayItemComponent({
    this.role,
    this.displayCondition,
    this.content,
    this.disabled,
    this.style,
    this.key,
  }) {
    if (!(displayItemComponentRoles.contains(role))) {
      throw InvalidRoleException(
          message: 'Expected roles in the list $displayItemComponentRoles');
    }
  }

  DisplayItemComponent copyWith({
    String role,
    Expression displayCondition,
    List<LocalizedObject> content,
    Expression disabled,
    Map<String, String> style,
    String key,
  }) {
    return DisplayItemComponent(
      role: role ?? this.role,
      displayCondition: displayCondition ?? this.displayCondition,
      content: content ?? this.content,
      disabled: disabled ?? this.disabled,
      style: style ?? this.style,
      key: key ?? this.key,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'displayCondition': displayCondition?.toMap(),
      'content': List<dynamic>.from(content.map((x) => x?.toMap())),
      'disabled': disabled?.toMap(),
      'style': style,
      'key': key,
    };
  }

  static DisplayItemComponent fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DisplayItemComponent(
      role: map['role'],
      displayCondition: Expression.fromMap(map['displayCondition']),
      content: List<LocalizedObject>.from(
          map['content']?.map((x) => LocalizedObject.fromMap(x))),
      disabled: Expression.fromMap(map['disabled']),
      style: map['style'],
      key: map['key'],
    );
  }

  String toJson() => json.encode(toMap());

  static DisplayItemComponent fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'DisplayItemComponent role: $role, displayCondition: $displayCondition, content: $content, disabled: $disabled, style: $style, key: $key';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DisplayItemComponent &&
        o.role == role &&
        o.displayCondition == displayCondition &&
        o.content == content &&
        o.disabled == disabled &&
        o.style == style &&
        o.key == key;
  }

  @override
  int get hashCode {
    return role.hashCode ^
        displayCondition.hashCode ^
        content.hashCode ^
        disabled.hashCode ^
        style.hashCode ^
        key.hashCode;
  }
}

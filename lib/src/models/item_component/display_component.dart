import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_component.dart';
import 'package:survey_engine.dart/src/models/item_component/properties.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';

class DisplayComponent implements ItemComponent {
  String role;
  Expression displayCondition;
  List<LocalizedObject> content;
  List<LocalizedObject> description;
  Expression disabled;
  List<Map<String, String>> style;
  String key;
  String dtype = null;
  Properties properties = null;
  List<ItemComponent> items = null;
  Expression order = null;
  DisplayComponent(
      {this.role,
      this.displayCondition,
      this.content,
      this.description,
      this.disabled,
      this.style,
      this.key}) {
    if (!(displayItemComponentRoles.contains(role))) {
      throw InvalidRoleException(
          message: 'Expected roles in the list $displayItemComponentRoles');
    }
  }

  Map<String, dynamic> toMap() {
    return Utils.removeNullParams({
      'role': role,
      'displayCondition': displayCondition?.toMap(),
      'content': Utils.resolveNullListOfMaps(content),
      'description': Utils.resolveNullListOfMaps(description),
      'disabled': disabled?.toMap(),
      'style': style,
      'key': key,
    });
  }

  static DisplayComponent fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DisplayComponent(
      role: map['role'],
      displayCondition: Expression.fromMap(map['displayCondition']),
      content: (map['content'] == null)
          ? null
          : List<LocalizedObject>.from(
              map['content']?.map((x) => LocalizedObject.fromMap(x))),
      description: (map['description'] == null)
          ? null
          : List<LocalizedObject>.from(
              map['description']?.map((x) => LocalizedObject.fromMap(x))),
      disabled: Expression.fromMap(map['disabled']),
      style: map['style'],
      key: map['key'],
    );
  }

  String toJson() => json.encode(toMap());

  static DisplayComponent fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'DisplayComponent role: $role, displayCondition: $displayCondition, content: $content, description:$description, disabled: $disabled, style: $style, key: $key';
  }
}

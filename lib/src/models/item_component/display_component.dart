import 'dart:collection';
import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_component.dart';
import 'package:survey_engine.dart/src/models/item_component/properties.dart';
import 'package:survey_engine.dart/src/models/item_component/style_component.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_string.dart';

class DisplayComponent implements ItemComponent {
  String role;
  Expression displayCondition;
  List<LocalizedObject> content;
  List<LocalizedString> description;
  Expression disabled;
  List<Style> style;
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
      'style': Utils.resolveNullListOfMaps(style),
      'key': key,
    });
  }

  static DisplayComponent fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      return DisplayComponent(
        role: map['role'],
        displayCondition: Expression.fromMap(map['displayCondition']),
        content: (map['content'] == null)
            ? null
            : List<LocalizedString>.from(
                map['content']?.map((x) => LocalizedString.fromMap(x))),
        description: (map['description'] == null)
            ? null
            : List<LocalizedString>.from(
                map['description']?.map((x) => LocalizedString.fromMap(x))),
        disabled: Expression.fromMap(map['disabled']),
        style: (map['style'] == null)
            ? null
            : List<Style>.from(map['style']?.map((x) => Style.fromMap(x))),
        key: map['key'],
      );
    } catch (e) {
      throw MapCreationException(className: 'DisplayComponent', map: map);
    }
  }

  String toJson() => json.encode(HashMap.from(toMap()));

  static DisplayComponent fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'DisplayComponent role: $role, displayCondition: $displayCondition, content: $content, description:$description, disabled: $disabled, style: $style, key: $key';
  }
}

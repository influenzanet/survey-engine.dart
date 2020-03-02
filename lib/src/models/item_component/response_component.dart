import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_component.dart';
import 'package:survey_engine.dart/src/models/item_component/properties.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';

class ResponseComponent implements ItemComponent {
  String role;
  Expression displayCondition;
  List<LocalizedObject> content;
  Expression disabled;
  Map<String, String> style;
  String key;
  String dType;
  Properties properties;
  List<ItemComponent> items = null;
  Expression order = null;
  ResponseComponent(
      {this.role,
      this.displayCondition,
      this.content,
      this.disabled,
      this.style,
      this.key,
      this.dType = 'string',
      this.properties}) {
    if (!responseDataType.contains(this.dType)) {
      throw InvalidResponseException(
          message:
              'Expected response data types in the list $responseDataType');
    }
    if (!responseComponentRoles.contains(role)) {
      throw InvalidRoleException(
          message: 'Expected roles in the list $responseComponentRoles');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'displayCondition': displayCondition?.toMap(),
      'content': List<dynamic>.from(content.map((x) => x?.toMap())),
      'disabled': disabled?.toMap(),
      'style': style,
      'key': key,
      'dType': dType,
      'properties': properties?.toMap(),
    };
  }

  static ResponseComponent fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ResponseComponent(
      role: map['role'],
      displayCondition: Expression.fromMap(map['displayCondition']),
      content: List<LocalizedObject>.from(
          map['content']?.map((x) => LocalizedObject.fromMap(x))),
      disabled: Expression.fromMap(map['disabled']),
      style: map['style'],
      key: map['key'],
      dType: map['dType'] ?? 'string',
      properties: Properties.fromMap(map['properties']),
    );
  }

  String toJson() => json.encode(toMap());

  static ResponseComponent fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResponseComponent role: $role, displayCondition: $displayCondition, content: $content, disabled: $disabled, style: $style, key: $key, dType: $dType, properties: $properties';
  }
}

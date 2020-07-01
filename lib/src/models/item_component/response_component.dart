import 'dart:collection';
import 'dart:convert';

import 'package:influenzanet_survey_engine/src/controller/exceptions.dart';
import 'package:influenzanet_survey_engine/src/controller/utils.dart';
import 'package:influenzanet_survey_engine/src/models/constants.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/item_component.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/properties.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/style_component.dart';
import 'package:influenzanet_survey_engine/src/models/localized_object/localized_object.dart';
import 'package:influenzanet_survey_engine/src/models/localized_object/localized_string.dart';

class ResponseComponent implements ItemComponent {
  String role;
  Expression displayCondition;
  List<LocalizedObject> content;
  List<LocalizedString> description;
  Expression disabled;
  List<Style> style;
  String key;
  String dtype;
  Properties properties;
  List<ItemComponent> items = null;
  Expression order = null;
  ResponseComponent(
      {this.role,
      this.displayCondition,
      this.content,
      this.description,
      this.disabled,
      this.style,
      this.key,
      this.dtype = 'string',
      this.properties}) {
    if (!responseDataType.contains(this.dtype)) {
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
    return Utils.removeNullParams({
      'role': role,
      'displayCondition': displayCondition?.toMap(),
      'content': Utils.resolveNullListOfMaps(content),
      'description': Utils.resolveNullListOfMaps(description),
      'disabled': disabled?.toMap(),
      'style': Utils.resolveNullListOfMaps(style),
      'key': key,
      'dtype': dtype ?? 'string',
      'properties': properties?.toMap(),
    });
  }

  static ResponseComponent fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      return ResponseComponent(
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
        dtype: map['dtype'] ?? 'string',
        properties: Properties.fromMap(map['properties']),
      );
    } catch (e) {
      throw MapCreationException(className: 'ResponseComponent', map: map);
    }
  }

  String toJson() => json.encode(HashMap.from(toMap()));

  static ResponseComponent fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResponseComponent role: $role, displayCondition: $displayCondition, content: $content, description:$description, disabled: $disabled, style: $style, key: $key, dtype: $dtype, properties: $properties';
  }
}

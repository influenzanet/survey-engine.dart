import 'dart:collection';
import 'dart:convert';

import 'package:influenzanet_survey_engine/src/controller/exceptions.dart';
import 'package:influenzanet_survey_engine/src/controller/utils.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/item_component.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/properties.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/style_component.dart';
import 'package:influenzanet_survey_engine/src/models/localized_object/localized_object.dart';
import 'package:influenzanet_survey_engine/src/models/localized_object/localized_string.dart';

class ItemGroupComponent implements ItemComponent {
  String role;
  Expression displayCondition = null;
  List<LocalizedObject> content = null;
  List<LocalizedString> description = null;
  Expression disabled = null;
  List<Style> style = null;
  String key = null;
  String dtype = null;
  Properties properties = null;
  List<ItemComponent> items;
  Expression order;
  ItemGroupComponent({
    this.role,
    this.displayCondition,
    this.content,
    this.description,
    this.disabled,
    this.style,
    this.key,
    this.dtype,
    this.properties,
    this.items,
    this.order,
  }) {
    // Make sure that order name defaults to sequential if not present
    if (this.order == null) {
      this.order = Expression(name: 'sequential');
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
      'items': Utils.resolveNullListOfMaps(items),
      'order': order?.toMap(),
    });
  }

  static ItemGroupComponent fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      var temp = map['items']?.map((x) => ItemComponent(x));
      var tempData = (temp == null) ? null : List<ItemComponent>.from(temp);
      return ItemGroupComponent(
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
        items: tempData,
        order: Expression.fromMap(map['order']),
      );
    } catch (e) {
      throw MapCreationException(className: 'ItemGroupComponent', map: map);
    }
  }

  String toJson() => json.encode(HashMap.from(toMap()));

  static ItemGroupComponent fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemGroupComponent(role: $role, displayCondition: $displayCondition, content: $content, disabled: $disabled, style: $style, key: $key, dtype: $dtype, properties: $properties, items: $items, order: $order)';
  }
}

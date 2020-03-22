import 'dart:convert';

import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_component.dart';
import 'package:survey_engine.dart/src/models/item_component/properties.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';

class ItemGroupComponent implements ItemComponent {
  String role;
  Expression displayCondition = null;
  List<LocalizedObject> content = null;
  List<LocalizedObject> description = null;
  Expression disabled = null;
  Map<String, String> style = null;
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
    return {
      'role': role,
      'items': List<dynamic>.from(items.map((x) => x.toMap())),
      'order': order?.toMap(),
    };
  }

  static ItemGroupComponent fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ItemGroupComponent(
      role: map['role'],
      items:
          List<ItemComponent>.from(map['items']?.map((x) => ItemComponent(x))),
      order: Expression.fromMap(map['order']),
    );
  }

  String toJson() => json.encode(toMap());

  static ItemGroupComponent fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemGroupComponent(role: $role, displayCondition: $displayCondition, content: $content, disabled: $disabled, style: $style, key: $key, dtype: $dtype, properties: $properties, items: $items, order: $order)';
  }
}

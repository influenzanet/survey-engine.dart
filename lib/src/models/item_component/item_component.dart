import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/display_component.dart';
import 'package:survey_engine.dart/src/models/item_component/item_group_component.dart';
import 'package:survey_engine.dart/src/models/item_component/properties.dart';
import 'package:survey_engine.dart/src/models/item_component/response_component.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';

abstract class ItemComponent {
  String role;
  Expression displayCondition;
  List<LocalizedObject> content;
  Expression disabled;
  Map<String, String> style;
  String key;
  String dtype = 'string';
  Properties properties;
  List<ItemComponent> items;
  Expression order;
  factory ItemComponent(Map<String, dynamic> map) {
    if (displayItemComponentRoles.contains(map['role'])) {
      return DisplayComponent(
        role: map['role'],
        displayCondition: Expression.fromMap(map['displayCondition']),
        content: List<LocalizedObject>.from(
            map['content']?.map((x) => LocalizedObject.fromMap(x))),
        style: map['style'],
      );
    } else if (responseComponentRoles.contains(map['role'])) {
      return ResponseComponent(
        role: map['role'],
        displayCondition: Expression.fromMap(map['displayCondition']),
        content: List<LocalizedObject>.from(
            map['content']?.map((x) => LocalizedObject.fromMap(x))),
        disabled: Expression.fromMap(map['disabled']),
        style: map['style'],
        key: map['key'],
        dtype: map['dtype'] ?? 'string',
        properties: Properties.fromMap(map['properties']),
      );
    } else if (itemGroupRoles.contains(map['role'])) {
      return ItemGroupComponent(
        role: map['role'],
        items: List<ItemComponent>.from(
            map['items']?.map((x) => ItemComponent(x))),
        order: Expression.fromMap(map['order']),
      );
    }
    // Dummy needs to be changed after other Item Components creation
    throw "Error";
  }
  Map<String, dynamic> toMap();
  String toJson();
}

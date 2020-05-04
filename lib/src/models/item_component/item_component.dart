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
  List<LocalizedObject> description;
  Expression disabled;
  List<Map<String, String>> style;
  String key;
  String dtype = 'string';
  Properties properties;
  List<ItemComponent> items;
  Expression order;
  factory ItemComponent(Map<String, dynamic> map) {
    if (displayItemComponentRoles.contains(map['role'])) {
      return DisplayComponent.fromMap(map);
    } else if (responseComponentRoles.contains(map['role'])) {
      return ResponseComponent.fromMap(map);
    } else if (itemGroupRoles.contains(map['role'])) {
      return ItemGroupComponent.fromMap(map);
    }
    // Dummy needs to be changed after other Item Components creation
    throw "Error";
  }
  Map<String, dynamic> toMap();
  String toJson();
}

import 'package:influenzanet_survey_engine/src/models/constants.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/display_component.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/item_group_component.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/properties.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/response_component.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/style_component.dart';
import 'package:influenzanet_survey_engine/src/models/localized_object/localized_object.dart';
import 'package:influenzanet_survey_engine/src/models/localized_object/localized_string.dart';

abstract class ItemComponent {
  String role;
  Expression displayCondition;
  List<LocalizedObject> content;
  List<LocalizedString> description;
  Expression disabled;
  List<Style> style;
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

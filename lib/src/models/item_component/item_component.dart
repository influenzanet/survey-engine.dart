import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/display_component.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';

abstract class ItemComponent {
  String role;
  Expression displayCondition;
  List<LocalizedObject> content;
  Expression disabled;
  Map<String, String> style;
  String key;
  factory ItemComponent(Map<String, dynamic> map) {
    if (displayItemComponentRoles.contains(map['role'])) {
      return DisplayComponent(
        role: map['role'],
        displayCondition: Expression.fromMap(map['displayCondition']),
        content: List<LocalizedObject>.from(
            map['content']?.map((x) => LocalizedObject.fromMap(x))),
        style: map['style'],
      );
    }
    // Dummy needs to be changed after other Item Components creation
    throw "Error";
  }
  String get jsonValue;
}

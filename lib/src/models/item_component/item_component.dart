import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_group_component.dart';
import 'package:survey_engine.dart/src/models/item_component/response_component.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';

class ItemComponent {
  String role;
  Expression displayCondition;
  List<LocalizedObject> content;
  Expression disabled;
  Map<String, String> style;
  String key;
  ItemGroupComponent items;
  ResponseComponent responseComponent;
  ItemComponent({
    this.role,
    this.displayCondition,
    this.content,
    this.disabled,
    this.style,
    this.key,
    this.items,
    this.responseComponent,
  });
}

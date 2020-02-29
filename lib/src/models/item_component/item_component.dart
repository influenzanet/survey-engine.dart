import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';

class ItemComponent {
  String role;
  Expression displayCondition;
  List<LocalizedObject> content;
  Expression disabled;
  Map<String, String> style;
  String key;
  ItemComponent([
    this.role,
    this.displayCondition,
    this.content,
    this.disabled,
    this.style,
    this.key,
  ]);
}

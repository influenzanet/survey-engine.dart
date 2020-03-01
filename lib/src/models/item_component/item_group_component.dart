import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_component.dart';

class ItemGroupComponent extends ItemComponent {
  List<ItemComponent> items;
  Expression order;
}

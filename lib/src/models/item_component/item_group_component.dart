import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_component.dart';

class ItemGroupComponent {
  List<ItemComponent> items;
  Expression order;
  ItemGroupComponent({
    this.items,
    this.order,
  }) {
    if (!(['sequential', 'random', 'randomSeed'].contains(order.name))) {
      throw InvalidArgumentsException();
    }
  }
}

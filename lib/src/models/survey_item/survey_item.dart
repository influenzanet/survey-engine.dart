import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_group_component.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_single_item.dart';
import 'package:survey_engine.dart/src/models/survey_item/validations.dart';

abstract class SurveyItem {
  String key;
  List<String> follows;
  Expression condition;
  int priority;
  int version;
  List<String> versionTags;
  String type;
  ItemGroupComponent components;
  List<Validations> validation;
  List<SurveyItem> items;
  Expression selectionMethod;
  Map<String, dynamic> toMap();
  factory SurveyItem(Map<String, dynamic> map) {
    // SurveySingleItem does not have a selection method
    if (map['selectionMethod'] == null) {
      var temp = map['validations']?.map((x) => Validations.fromMap(x));
      var tempValidation = List<Validations>.from(temp);
      return SurveySingleItem(
          type: map['type'],
          components: ItemGroupComponent?.fromMap(map['components']),
          validation: tempValidation,
          key: map['key'],
          follows: map['follows'],
          condition: map['condition'],
          priority: map['priority'],
          version: map['version'],
          versionTags: map['versionTags']);
    }
    throw 'Error';
  }
}

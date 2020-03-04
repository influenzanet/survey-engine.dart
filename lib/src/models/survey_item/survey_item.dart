import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_group_component.dart';
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
}

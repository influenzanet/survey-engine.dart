import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/item_group_component.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_group_item.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_single_item.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/validations.dart';

abstract class SurveyItem {
  String key;
  List<String> follows;
  Expression condition;
  int priority;
  int version;
  List<String> versionTags;
  String type;
  ItemGroupComponent components;
  List<Validations> validations;
  List<SurveyItem> items;
  Expression selectionMethod;
  factory SurveyItem(Map<String, dynamic> map) {
    // SurveySingleItem does not have an items List
    if (map['items'] == null) {
      return SurveySingleItem.fromMap(map);
    } else {
      return SurveyGroupItem.fromMap(map);
    }
  }
  Map<String, dynamic> toMap();
  String toJson();
}

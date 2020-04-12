import 'dart:convert';

import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_group_component.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_item.dart';
import 'package:survey_engine.dart/src/models/survey_item/validations.dart';

class SurveyGroupItem implements SurveyItem {
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
  // SelectionMethod is used when rendering so tests will be written after engine development
  Expression selectionMethod;
  SurveyGroupItem(
      {this.items,
      this.selectionMethod,
      this.key,
      this.follows,
      this.condition,
      this.priority,
      this.version,
      this.versionTags});

  Map<String, dynamic> toMap() {
    return Utils.removeNullParams({
      'key': key,
      'follows': follows,
      'condition': condition,
      'priority': priority,
      'version': version,
      'versionTags': versionTags,
      'items': Utils.resolveNullListOfMaps(items),
      'selectionMethod': selectionMethod?.toMap(),
    });
  }

  static SurveyGroupItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    var temp = map['items']?.map((x) => SurveyItem(x));
    var tempData = List<SurveyItem>.from(temp);

    return SurveyGroupItem(
        items: tempData,
        selectionMethod: Expression.fromMap(map['selectionMethod']),
        key: map['key'],
        follows: map['follows'],
        condition: map['condition'],
        priority: map['priority'],
        version: map['version'],
        versionTags: map['versionTags']);
  }

  String toJson() => json.encode(toMap());

  static SurveyGroupItem fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'SurveyGroupItem(items: $items, selectionMethod: $selectionMethod)';
}

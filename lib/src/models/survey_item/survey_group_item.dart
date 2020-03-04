import 'dart:convert';

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
  List<Validations> validation;
  List<SurveyItem> items;
  Expression selectionMethod;
  SurveyGroupItem({
    this.items,
    this.selectionMethod,
  });

  Map<String, dynamic> toMap() {
    return {
      'items': List<dynamic>.from(items.map((x) => x.toMap())),
      'selectionMethod': selectionMethod.toMap(),
    };
  }

  static SurveyGroupItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SurveyGroupItem(
      items: List<SurveyItem>.from(map['items']?.map((x) => x)),
      selectionMethod: Expression.fromMap(map['selectionMethod']),
    );
  }

  String toJson() => json.encode(toMap());

  static SurveyGroupItem fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'SurveyGroupItem(items: $items, selectionMethod: $selectionMethod)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SurveyGroupItem &&
        o.items == items &&
        o.selectionMethod == selectionMethod;
  }

  @override
  int get hashCode => items.hashCode ^ selectionMethod.hashCode;
}

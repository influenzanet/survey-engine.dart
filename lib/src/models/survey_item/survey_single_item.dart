import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_group_component.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_item.dart';
import 'package:survey_engine.dart/src/models/survey_item/validations.dart';

class SurveySingleItem implements SurveyItem {
  String type;
  ItemGroupComponent components;
  List<Validations> validation;
  List<SurveyItem> items;
  Expression selectionMethod;
  String key;
  List<String> follows;
  Expression condition;
  int priority;
  int version;
  List<String> versionTags;
  SurveySingleItem(
      {this.type,
      this.components,
      this.validation,
      this.key,
      this.follows,
      this.condition,
      this.priority,
      this.version,
      this.versionTags}) {
    if (!itemTypes.contains(this.type)) {
      throw InvalidItemTypeException(
          message: 'Expected types $itemTypes but got $this.type');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'components': components.toMap(),
      'validation': List<dynamic>.from(validation.map((x) => x.toMap())),
      'key': key,
      'follows': follows,
      'condition': condition,
      'priority': priority,
      'version': version,
      'versionTags': versionTags
    };
  }

  static SurveySingleItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    var temp = map['validations']?.map((x) => Validations.fromMap(x));
    var tempValidation = (temp != null) ? List<Validations>.from(temp) : null;
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

  String toJson() => json.encode(toMap());

  static SurveySingleItem fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'SurveySingleItem(type: $type, components: $components, validation: $validation)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SurveySingleItem &&
        o.type == type &&
        o.components == components &&
        o.validation == validation;
  }

  @override
  int get hashCode => type.hashCode ^ components.hashCode ^ validation.hashCode;
}

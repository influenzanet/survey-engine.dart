import 'dart:collection';
import 'dart:convert';

import 'package:influenzanet_survey_engine/src/controller/exceptions.dart';
import 'package:influenzanet_survey_engine/src/controller/utils.dart';

class ResponseItem {
  String key;
  String value;
  String dtype;
  List<ResponseItem> items;
  ResponseItem({
    this.key,
    this.value,
    this.dtype,
    this.items,
  });

  Map<String, dynamic> toMap() {
    return Utils.removeNullParams({
      'key': key,
      'value': value,
      'dtype': dtype,
      'items': Utils.resolveNullListOfMaps(items),
    });
  }

  static ResponseItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      var temp = map['items']?.map((x) => ResponseItem.fromMap(x));
      List<ResponseItem> tempData =
          (temp != null) ? List<ResponseItem>.from(temp) : null;
      return ResponseItem(
        key: map['key'],
        value: map['value'],
        dtype: map['dtype'],
        items: tempData,
      );
    } catch (e) {
      throw MapCreationException(className: 'ResponseItem', map: map);
    }
  }

  String toJson() => json.encode(HashMap.from(toMap()));

  static ResponseItem fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResponseItem(key: $key, value: $value, dtype: $dtype, items: $items)';
  }
}

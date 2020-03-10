import 'dart:convert';

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
    return {
      'key': key,
      'value': value,
      'dtype': dtype,
      'items': (items != null)
          ? List<dynamic>.from(items?.map((x) => x?.toMap()))
          : null,
    };
  }

  static ResponseItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    var temp = map['items']?.map((x) => ResponseItem.fromMap(x));
    List<ResponseItem> tempData =
        (temp != null) ? List<ResponseItem>.from(temp) : null;
    return ResponseItem(
      key: map['key'],
      value: map['value'],
      dtype: map['dtype'],
      items: tempData,
    );
  }

  String toJson() => json.encode(toMap());

  static ResponseItem fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResponseItem(key: $key, value: $value, dtype: $dtype, items: $items)';
  }
}

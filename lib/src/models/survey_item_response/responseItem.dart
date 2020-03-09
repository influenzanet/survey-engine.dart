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
      'items': List<dynamic>.from(items.map((x) => x.toMap())),
    };
  }

  static ResponseItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ResponseItem(
      key: map['key'],
      value: map['value'],
      dtype: map['dtype'],
      items: List<ResponseItem>.from(
          map['items']?.map((x) => ResponseItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static ResponseItem fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResponseItem(key: $key, value: $value, dtype: $dtype, items: $items)';
  }
}

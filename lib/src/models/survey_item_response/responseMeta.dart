import 'dart:convert';

class ResponseMeta {
  int position;
  String localeCode;
  int version;
  List<int> rendered;
  List<int> displayed;
  List<int> responded;
  ResponseMeta({
    this.position,
    this.localeCode,
    this.version,
    this.rendered,
    this.displayed,
    this.responded,
  });

  Map<String, dynamic> toMap() {
    return {
      'position': position,
      'localeCode': localeCode,
      'version': version,
      'rendered': List<dynamic>.from(rendered.map((x) => x)),
      'displayed': List<dynamic>.from(displayed.map((x) => x)),
      'responded': List<dynamic>.from(responded.map((x) => x)),
    };
  }

  static ResponseMeta fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ResponseMeta(
      position: map['position'],
      localeCode: map['localeCode'],
      version: map['version'],
      rendered: List<int>.from(map['rendered']),
      displayed: List<int>.from(map['displayed']),
      responded: List<int>.from(map['responded']),
    );
  }

  String toJson() => json.encode(toMap());

  static ResponseMeta fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResponseMeta(position: $position, localeCode: $localeCode, version: $version, rendered: $rendered, displayed: $displayed, responded: $responded)';
  }
}
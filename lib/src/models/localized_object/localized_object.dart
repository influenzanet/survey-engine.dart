import 'package:influenzanet_survey_engine/src/models/localized_object/localized_string.dart';

abstract class LocalizedObject {
  factory LocalizedObject(Map<String, dynamic> map) {
    return LocalizedString.fromMap(map);
  }
  Map<String, dynamic> toMap();
  String toJson();
}

import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';

class LocalisedString {
  static String getLocalisedString(LocalizedObject localizedObject) {
    List<String> localisedString = [];
    localizedObject.parts.forEach((expressionArg) {
      localisedString.add(expressionArg.str);
    });
    return localisedString.join();
  }
}

import 'dart:convert';

import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/surveyItemResponse.dart';

class SurveyContext {
  List<SurveyItemResponse> previousResponses;
  dynamic profile;
  String mode;
  // To do: The model needs to be defined. Context fetches data from the mobile application. Currently `mode` is used for test strings.
  SurveyContext({
    this.previousResponses,
    this.profile,
    this.mode,
  });

  Map<String, dynamic> toMap() {
    return {
      'previousResponses': Utils.resolveNullListOfMaps(previousResponses),
      'profile': profile,
      'mode': mode,
    };
  }

  static SurveyContext fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    var temp = map['data']?.map((x) => SurveyItemResponse(x));
    var tempData = List<SurveyItemResponse>.from(temp);

    return SurveyContext(
      previousResponses: tempData,
      profile: map['profile'],
      mode: map['mode'],
    );
  }

  String toJson() => json.encode(toMap());

  static SurveyContext fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'SurveyContext(previousResponses: $previousResponses, profile: $profile, mode: $mode)';
}

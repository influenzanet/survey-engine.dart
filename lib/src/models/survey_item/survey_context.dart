import 'dart:collection';
import 'dart:convert';

import 'package:influenzanet_survey_engine/src/controller/exceptions.dart';
import 'package:influenzanet_survey_engine/src/controller/utils.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item_response/survey_item_response.dart';

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
    return Utils.removeNullParams({
      'previousResponses': Utils.resolveNullListOfMaps(previousResponses),
      'profile': profile,
      'mode': mode,
    });
  }

  static SurveyContext fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      var temp = map['data']?.map((x) => SurveyItemResponse(x));
      var tempData = List<SurveyItemResponse>.from(temp);

      return SurveyContext(
        previousResponses: tempData,
        profile: map['profile'],
        mode: map['mode'],
      );
    } catch (e) {
      throw MapCreationException(className: 'SurveyContext', map: map);
    }
  }

  String toJson() => json.encode(HashMap.from(toMap()));

  static SurveyContext fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'SurveyContext(previousResponses: $previousResponses, profile: $profile, mode: $mode)';
}

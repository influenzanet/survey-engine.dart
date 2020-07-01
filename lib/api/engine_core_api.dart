import 'package:influenzanet_survey_engine/src/controller/engine_core.dart';
import 'package:influenzanet_survey_engine/src/controller/expression_eval.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_context.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_group_item.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item_response/response_item.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item_response/survey_group_item_response.dart';

abstract class SurveyEngineCoreApi {
  SurveyGroupItem surveyDef;
  SurveyGroupItemResponse responses;
  SurveyContext context;
  ExpressionEvaluation evalEngine;
  factory SurveyEngineCoreApi(
      {SurveyGroupItem surveyDef,
      SurveyGroupItemResponse responses,
      SurveyContext context,
      ExpressionEvaluation evalEngine}) {
    return SurveyEngineCore(
        surveyDef: surveyDef, context: context, evalEngine: evalEngine);
  }

// Data functions
  Map<String, dynamic> toMap();
  String toJson();
  String toString();

// Getters and setters
  setContext(SurveyContext context);
  setResponse({String key, ResponseItem response});
  dynamic questionDisplayed(String key);
  dynamic getRenderedSurvey();
  dynamic getResponses();
  dynamic flattenSurveyItemtree();
}

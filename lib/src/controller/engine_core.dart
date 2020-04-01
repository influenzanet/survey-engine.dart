import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_group_component.dart';
import 'package:survey_engine.dart/src/models/item_component/properties.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_context.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_group_item.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_single_item.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/response_meta.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_item_response.dart';

class SurveyEngineCore {
  SurveyGroupItem surveyDef;
  SurveyGroupItemResponse responses;
  SurveyContext context;
  ExpressionEvaluation evalEngine;
  SurveyEngineCore({
    this.surveyDef,
    this.context,
    this.evalEngine,
  }) {
    this.evalEngine = ExpressionEvaluation(context: this.context);
    this.responses = initSurveyGroupItemResponse(this.surveyDef);
  }

// Data functions
  Map<String, dynamic> toMap() {
    return {
      'surveyDef': surveyDef.toMap(),
      'responses': responses?.toMap(),
      'context': context?.toMap(),
    };
  }

  static SurveyEngineCore fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SurveyEngineCore(
      surveyDef: SurveyGroupItem.fromMap(map['surveyDef']),
      context: SurveyContext?.fromMap(map['context']),
    );
  }

  String toJson() => json.encode(toMap());

  static SurveyEngineCore fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'SurveyEngineCore(surveyDef: $surveyDef, responses: $responses, context: $context, evalEngine: $evalEngine)';
  }

// Init functions
  SurveyGroupItemResponse initSurveyGroupItemResponse(
      SurveyGroupItem questionGroup) {
    if (questionGroup == null) return null;
    SurveyGroupItemResponse responseGroup = SurveyGroupItemResponse(
        key: questionGroup.key,
        items: [],
        meta: ResponseMeta(version: questionGroup.version));
    questionGroup.items.forEach((item) {
      if (item.items == null) {
        SurveyItemResponse response = SurveyItemResponse({
          'key': item.key,
          'meta': {
            'version': item.version,
          },
        });
        responseGroup.items.add(response);
      } else {
        responseGroup.items.add(initSurveyGroupItemResponse(item));
      }
    });
    return responseGroup;
  }

// Resolution of responses
  SurveyItemResponse setTimestampFor(
      String timeStampType, SurveyItemResponse responseObject) {
    if (responseObject == null) return null;
    if (!(timeStampTypes.contains(timeStampType))) {
      throw InvalidTimestampException(
          message:
              'Wrong timestamp type $timeStampType valid timestamps are $timeStampTypes');
    }
    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    switch (timeStampType) {
      case 'rendered':
        responseObject.meta.rendered.add(timestamp);
        break;
      case 'displayed':
        responseObject.meta.displayed.add(timestamp);
        break;
      case 'responded':
        responseObject.meta.responded.add(timestamp);
        break;
    }
    return responseObject;
  }

// Item Component resolution functions
  Map<Object, Object> resolveItemComponentProperties(Properties props) {
    ExpressionEvaluation eval = ExpressionEvaluation();
    Map<Object, Object> propertiesMap = {
      'min': eval.evaluateArgument(props.min),
      'max': eval.evaluateArgument(props.max),
      'stepSize': eval.evaluateArgument(props.stepSize)
    };
    return propertiesMap;
  }

  String resolveContent(List<LocalizedObject> content) {
    String resolvedContent = '';
    content.forEach((localizedObject) {
      resolvedContent =
          resolvedContent + Utils.getLocalisedString(localizedObject);
    });
    return resolvedContent;
  }

  bool evaluateBooleanResult(Expression expression) {
    ExpressionEvaluation eval = ExpressionEvaluation();
    // Display condition must always be of boolean type
    if (Expression == null || expression?.returnType != 'boolean') {
      return false;
    }
    return eval.evalExpression(expression: expression);
  }

  dynamic resolveItemComponentGroup(ItemGroupComponent component) {
    List resolvedItems = [];
    component.items.forEach((itemComponent) {
      Map<String, Object> resolvedItemComponent = itemComponent.toMap();
      resolvedItemComponent['displayCondition'] =
          evaluateBooleanResult(itemComponent.displayCondition);
      resolvedItemComponent['content'] = resolveContent(itemComponent.content);
      //resolvedItemComponent['description'] = resolveContent(itemComponent.description);
      resolvedItemComponent['disabled'] =
          evaluateBooleanResult(itemComponent.disabled);
      resolvedItemComponent['properties'] =
          resolveItemComponentProperties(itemComponent.properties);
      resolvedItems.add(resolvedItemComponent);
    });
    Map<String, Object> resolvedItemGroupComponent = component.toMap();
    resolvedItemGroupComponent['items'] = resolvedItems;
    resolvedItemGroupComponent =
        Utils.removeNullParams(resolvedItemGroupComponent);
    return resolvedItemGroupComponent;
  }

  dynamic renderSurveySingleItem(SurveySingleItem surveySingleItem) {
    Map<String, Object> renderedItem = surveySingleItem.toMap();
    List<Map<String, Object>> renderedValidations = [];
    surveySingleItem.validation?.forEach((validation) {
      Map<String, Object> validationMap = validation.toMap();
      validationMap['rule'] = evaluateBooleanResult(validation.rule);
      renderedValidations.add(validationMap);
    });
    renderedItem['components'] =
        resolveItemComponentGroup(surveySingleItem.components);
    renderedItem['validation'] = renderedValidations;
    renderedItem = Utils.removeNullParams(renderedItem);
    return renderedItem;
  }
}

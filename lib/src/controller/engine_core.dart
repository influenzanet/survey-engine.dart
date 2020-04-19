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
import 'package:survey_engine.dart/src/models/survey_item/survey_item.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_single_item.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/response_meta.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_item_response.dart';

class SurveyEngineCore {
  SurveyGroupItem surveyDef;
  SurveyGroupItemResponse responses;
  SurveyContext context;
  dynamic renderedSurvey;
  ExpressionEvaluation evalEngine;
  SurveyEngineCore({
    this.surveyDef,
    this.context,
    this.evalEngine,
  }) {
    this.evalEngine = ExpressionEvaluation(context: this.context);
    this.responses = initSurveyGroupItemResponse(this.surveyDef);
    this.renderedSurvey = {
      'key': this.surveyDef != null ? this.surveyDef.key : '',
      'version': this.surveyDef != null ? this.surveyDef.version : '',
      'items': []
    };
    this.responses = setTimestampFor('rendered', this.responses);
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

  dynamic initRenderedGroupItem(SurveyGroupItem questionGroup) {
    if (questionGroup == null) return null;
    var renderedGroup = questionGroup.toMap();
    renderedGroup['items'] = [];
    int i = 0;
    while (i < questionGroup.items.length) {
      dynamic item =
          getNextItem(questionGroup, renderedGroup, questionGroup.key, false);
      //var item = questionGroup.items[i];
      if (item['items'] == null) {
        dynamic rendered =
            renderSurveySingleItem(SurveySingleItem.fromMap(item));
        renderedGroup['items'].add(rendered);
        // add timestamp
      } else {
        renderedGroup['items']
            .add(initRenderedGroupItem(SurveyGroupItem.fromMap(item)));
      }
      i++;
    }
    return renderedGroup;
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
    if (props == null) return null;
    ExpressionEvaluation eval = ExpressionEvaluation();
    Map<Object, Object> propertiesMap = {
      'min': eval.evaluateArgument(props.min),
      'max': eval.evaluateArgument(props.max),
      'stepSize': eval.evaluateArgument(props.stepSize)
    };
    return Utils.removeNullParams(propertiesMap);
  }

  List<Map<String, Object>> resolveContent(List<LocalizedObject> content) {
    if (content == null) return null;
    List<Map<String, Object>> resolvedContent = [];
    content.forEach((localizedObject) {
      Map<String, Object> resolvedLocalisedObject =
          Utils.getResolvedLocalisedObject(localizedObject);
      resolvedContent.add(Utils.removeNullParams(resolvedLocalisedObject));
    });
    return resolvedContent;
  }

  dynamic resolveItemComponentGroup(ItemGroupComponent component) {
    if (component == null) return null;
    var resolvedGroup = component.toMap();
    resolvedGroup['items'] = [];
    component.items.forEach((itemComponent) {
      if (itemComponent.items == null) {
        Map<String, Object> resolvedItemComponent = itemComponent.toMap();
        resolvedItemComponent['displayCondition'] =
            Utils.evaluateBooleanResult(itemComponent.displayCondition);
        resolvedItemComponent['content'] =
            resolveContent(itemComponent.content);
        // Description needs to be changed after discussion
        // resolvedItemComponent['description'] =resolveContent(itemComponent.description);
        // By default disabled
        resolvedItemComponent['disabled'] = Utils.evaluateBooleanResult(
            itemComponent.disabled,
            nullValue: false);
        resolvedItemComponent['properties'] =
            resolveItemComponentProperties(itemComponent.properties);
        resolvedGroup['items']
            .add(Utils.removeNullParams(resolvedItemComponent));
      } else {
        resolvedGroup['items'].add(
            Utils.removeNullParams(resolveItemComponentGroup(itemComponent)));
      }
    });
    return Utils.removeNullParams(resolvedGroup);
  }

// Rendering Survey Group Items
  dynamic renderSurveySingleItem(SurveySingleItem surveySingleItem) {
    Map<String, Object> renderedItem = surveySingleItem.toMap();
    List<Map<String, Object>> renderedValidations = [];
    surveySingleItem.validations?.forEach((validation) {
      Map<String, Object> validationMap = validation.toMap();
      validationMap['rule'] = Utils.evaluateBooleanResult(validation.rule);
      renderedValidations.add(validationMap);
    });
    renderedItem['components'] =
        resolveItemComponentGroup(surveySingleItem.components);
    renderedItem['validations'] = renderedValidations;
    return Utils.removeNullParams(renderedItem);
  }

// Helper functions

  dynamic getFollowUpItems(dynamic availableItems, String lastKey) {
    if (availableItems == null) return null;
    return availableItems
        .where((item) =>
            item['follows'] != null &&
            item['follows'].length > 0 &&
            item['follows'].contains(lastKey))
        .toList();
  }

  dynamic getItemsWithoutFollows(dynamic availableItems, String lastKey) {
    if (availableItems == null) return null;
    return availableItems
        .where((item) => item['follows'] == null || item['follows'].length == 0)
        .toList();
  }

  dynamic getUnrenderedItems(
      SurveyGroupItem surveyGroupItem, dynamic renderedParentGroup) {
    if (renderedParentGroup['items'] == null ||
        renderedParentGroup['items'].length == 0) {
      return surveyGroupItem.toMap()['items'].toList();
    }
    dynamic unRenderedItems = [];
    var renderedKeys = [];
    renderedParentGroup['items'].forEach((item) {
      renderedKeys.add(item['key']);
    });
    surveyGroupItem.items.forEach((item) {
      if (renderedKeys.contains(item.key)) {
        return;
      }
      unRenderedItems.add(item.toMap());
    });
    unRenderedItems = unRenderedItems.where((item) {
      return ((item['condition'] == null) ||
          (item['condition'] != null &&
              Utils.evaluateBooleanResult(
                  Expression.fromMap(item['condition']))));
    }).toList();
    return unRenderedItems;
  }

  dynamic getNextItem(SurveyGroupItem surveyGroupItem,
      dynamic renderedParentGroup, String lastKey, bool onlyDirectFollower) {
    // available items ==> fetch all unrendered groups in surveyGroupItem

    var availableItems =
        getUnrenderedItems(surveyGroupItem, renderedParentGroup);

    // Needs clarification
    if ((lastKey == null || lastKey.isEmpty) && onlyDirectFollower) {
      return null;
    }
    var followUpItems = getFollowUpItems(availableItems, lastKey);

    if (followUpItems != null && followUpItems.length > 0) {
      return SelectionMethods.pickAnItem(
          items: followUpItems, expression: surveyGroupItem.selectionMethod);
    } else if (onlyDirectFollower) {
      return null;
    }

    var groupPool = getItemsWithoutFollows(availableItems, lastKey);
    if (groupPool != null && groupPool.length == 0) {
      return null;
    }

    return SelectionMethods.pickAnItem(
        items: groupPool, expression: surveyGroupItem.selectionMethod);
  }

// Search objects by key
  SurveyItemResponse findResponseItem(String itemId,
      {SurveyItemResponse rootResponseItem}) {
    if (itemId == null) return null;
    SurveyItemResponse root = rootResponseItem ?? this.responses;
    if (Utils.getRootKey(root.key) != Utils.getRootKey(itemId)) {
      throw NotFoundException(object: itemId);
    }
    if (itemId == root.key) {
      return SurveyItemResponse(root.toMap());
    }
    String componentId = root.key;
    SurveyItemResponse result = SurveyItemResponse(root.toMap());
    List<String> ids = itemId.split(keyHierarchySeperator).sublist(firstItem);
    ids.forEach((id) {
      if (!(result is SurveyGroupItemResponse)) {
        return;
      }
      componentId = componentId + keyHierarchySeperator + id;
      SurveyItemResponse foundItem = result.items
          .firstWhere((item) => item.key == componentId, orElse: () => null);
      if (foundItem == null) {
        throw NotFoundException(object: itemId);
      } else
        result = foundItem;
    });
    return result;
  }

  SurveyItem findSurveyItem(String itemId, {SurveyItem rootItem}) {
    if (itemId == null) return null;
    SurveyItem root = rootItem ?? this.surveyDef;
    if (Utils.getRootKey(root.key) != Utils.getRootKey(itemId)) {
      throw NotFoundException(object: itemId);
    }
    if (itemId == root.key) {
      return SurveyItem(root.toMap());
    }
    String componentId = root.key;
    SurveyItem result = SurveyItem(root.toMap());
    List<String> ids = itemId.split(keyHierarchySeperator).sublist(firstItem);
    ids.forEach((id) {
      if (!(result is SurveyGroupItem)) {
        return;
      }
      componentId = componentId + keyHierarchySeperator + id;
      SurveyItem foundItem = result.items
          .firstWhere((item) => item.key == componentId, orElse: () => null);
      if (foundItem == null) {
        throw NotFoundException(object: itemId);
      } else
        result = foundItem;
    });
    return result;
  }
}

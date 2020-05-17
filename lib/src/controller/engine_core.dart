import 'dart:collection';
import 'dart:convert';

import 'package:survey_engine.dart/api/engine.dart';
import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_group_component.dart';
import 'package:survey_engine.dart/src/models/item_component/properties.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_string.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_context.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_group_item.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_item.dart';
import 'package:survey_engine.dart/src/models/survey_item/survey_single_item.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/response_item.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/response_meta.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_item_response.dart';
import 'package:survey_engine.dart/src/models/survey_item_response/survey_single_item_response.dart';

class SurveyEngineCore implements Engine {
  SurveyGroupItem surveyDef;
  SurveyGroupItemResponse responses;
  SurveyContext context;
  dynamic renderedSurvey;
  ExpressionEvaluation evalEngine;
  bool weedRemoval;
  SurveyEngineCore(
      {this.surveyDef,
      this.context,
      this.evalEngine,
      this.weedRemoval = false}) {
    this.evalEngine = ExpressionEvaluation(context: this.context);
    this.responses = initSurveyGroupItemResponse(this.surveyDef);
    if (this.surveyDef == null) {
      this.renderedSurvey = {'key': '', 'version': '', 'items': []};
    } else {
      this.renderedSurvey = initRenderedGroupItem(this.surveyDef);
    }
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

  String toJson() => json.encode(HashMap.from(toMap()));

  static SurveyEngineCore fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'SurveyEngineCore(surveyDef: $surveyDef, responses: $responses, context: $context, evalEngine: $evalEngine)';
  }

// Getters and setters
  setContext(SurveyContext context) {
    this.context = context;
  }

  setResponse({String key, ResponseItem response}) {
    if (key == null) {
      throw NullObjectException(object: key);
    }
    if (response == null) {
      throw NullObjectException(object: 'response');
    }
    this.responses = updateResponseItem(
        changeKey: key,
        responseGroup: this.responses,
        timeStampType: 'responded',
        newResponseItem: response);
    // Code to re-render tree WIP
    this.renderedSurvey = reRenderGroup(this.renderedSurvey);
  }

  dynamic questionDisplayed(String key) {
    print("Question displayed=\n" + key);
    updateResponseItem(
        changeKey: key,
        responseGroup: this.responses,
        timeStampType: 'displayed');
  }

  dynamic getRenderedSurvey() {
    if (this.weedRemoval == true) {
      removeConditionParameter(this.renderedSurvey);
      return this.renderedSurvey;
    }
    updateConditions(this.renderedSurvey);
    return this.renderedSurvey;
  }

  void removeConditionParameter(dynamic renderedGroup) {
    if (renderedGroup == null) {
      return;
    }
    renderedGroup.remove('condition');
    renderedGroup['items'].forEach((item) {
      item.remove('condition');
      if (item['items'] != null) {
        removeConditionParameter(item);
      }
      Utils.removeNullParams(renderedGroup);
    });
  }

  void updateConditions(dynamic renderedGroup) {
    if (renderedGroup == null) {
      return;
    }
    renderedGroup['condition'] = true;
    renderedGroup['items'].forEach((item) {
      item['condition'] = true;
      if (item['items'] != null) {
        updateConditions(item);
      }
    });
  }

  dynamic getResponses() {
    dynamic flattenedRenderedSurvey =
        Utils.getFlattenedRenderedSurvey(this.renderedSurvey);
    dynamic responses = [];
    for (int index = 0; index < flattenedRenderedSurvey.length; index++) {
      dynamic response =
          findResponseItem(flattenedRenderedSurvey[index]['key']);
      if (response == null) {
        break;
      }
      response.meta.position = index;
      responses.add(response.toMap());
    }
    return responses.toList();
  }

// Init functions
  SurveyGroupItemResponse initSurveyGroupItemResponse(
      SurveyGroupItem questionGroup) {
    if (questionGroup == null) return null;
    SurveyGroupItemResponse responseGroup = SurveyGroupItemResponse(
        key: questionGroup.key,
        items: [],
        meta: ResponseMeta(version: questionGroup.version));

    updateResponseItem(
        changeKey: questionGroup.key,
        responseGroup: this.responses,
        timeStampType: 'rendered');
    for (final item in questionGroup.items) {
      if (item.items == null) {
        SurveyItemResponse response = SurveyItemResponse({
          'key': item.key,
          'meta': {
            'version': item.version,
          },
        });
        updateResponseItem(
            changeKey: item.key,
            responseGroup: this.responses,
            timeStampType: 'rendered');
        responseGroup.items.add(response);
      } else {
        responseGroup.items.add(initSurveyGroupItemResponse(item));
      }
    }
    return responseGroup;
  }

  dynamic initRenderedGroupItem(SurveyGroupItem questionGroup) {
    if (questionGroup == null) return null;
    var renderedGroup = questionGroup.toMap();
    // renderedGroup['condition'] = resolveBooleanCondition(
    //     expression: Expression.fromMap(renderedGroup['condition']),
    //     nullValue: true);
    updateResponseItem(
        responseGroup: this.responses,
        changeKey: questionGroup.key,
        timeStampType: 'rendered');
    renderedGroup['items'] = [];
    int i = 0;
    while (i < questionGroup.items.length) {
      dynamic item =
          getNextItem(questionGroup, renderedGroup, questionGroup.key, false);
      if (item == null) {
        i++;
        continue;
      }
      if (item['items'] == null) {
        dynamic rendered =
            renderSurveySingleItem(SurveySingleItem.fromMap(item));
        renderedGroup['items'].add(rendered);

        updateResponseItem(
            responseGroup: this.responses,
            changeKey: item['key'],
            timeStampType: 'rendered');
      } else {
        renderedGroup['items']
            .add(initRenderedGroupItem(SurveyGroupItem.fromMap(item)));
      }
      i++;
    }
    if (this.weedRemoval == true) {
      if (renderedGroup['condition'] == true) {
        renderedGroup['condition'] = null;
      }
    }
    return renderedGroup;
  }

  dynamic reRenderGroup(dynamic renderedGroup) {
    if (renderedGroup == null || renderedGroup['items'] == null) {
      Warning(message: "Rendered group $renderedGroup not found");
      return null;
    }
    SurveyGroupItem groupDef =
        findSurveyItem(renderedGroup['key'], rootItem: this.surveyDef);
    if (groupDef == null || groupDef.items == null) {
      Warning(message: "Survey group $groupDef not found");
      return null;
    }

// Adding items to the front
    int currentIndex = 0;
    dynamic nextItem =
        getNextItem(groupDef, renderedGroup, renderedGroup['key'], true);
    while (nextItem != null) {
      if (nextItem['items'] == null) {
        dynamic rendered =
            renderSurveySingleItem(SurveySingleItem.fromMap(nextItem));
        renderedGroup['items'].insert(currentIndex, rendered);
        updateResponseItem(
            responseGroup: this.responses,
            changeKey: nextItem['key'],
            timeStampType: 'rendered');
      } else {
        renderedGroup['items']
            .add(initRenderedGroupItem(SurveyGroupItem.fromMap(nextItem)));
      }
      currentIndex++;
      nextItem = getNextItem(groupDef, renderedGroup, nextItem['key'], true);
    }
    // while (currentIndex < groupDef.items.length) {
    //   dynamic item =
    //       getNextItem(groupDef, renderedGroup, renderedGroup['key'], true);
    //   if (item == null) {
    //     currentIndex++;
    //     continue;
    //   }
    //   if (item['items'] == null) {
    //     dynamic rendered =
    //         renderSurveySingleItem(SurveySingleItem.fromMap(item));
    //     renderedGroup['items'].insert(renderedGroup['items'].length, rendered);
    //     // renderedGroup['items'].insert(renderedGroup['items'].length, rendered);
    //     // function to insert at a position use this in rerendering
    //     updateResponseItem(
    //         responseGroup: this.responses,
    //         changeKey: item['key'],
    //         timeStampType: 'rendered');
    //   } else {
    //     renderedGroup['items']
    //         .add(initRenderedGroupItem(SurveyGroupItem.fromMap(item)));
    //   }
    //   currentIndex++;
    // }

    renderedGroup['items'].forEach((item) {
      SurveyItem itemDefGroup =
          findSurveyItem(item['key'], rootItem: this.surveyDef);
      dynamic itemDef = itemDefGroup?.toMap();
      // itemDef['condition'] =
      //     resolveBooleanCondition(expression: itemDef['condition']);
      if (itemDef == null ||
          ((resolveBooleanCondition(
                      expression: Expression.fromMap(itemDef['condition'])) !=
                  null) &&
              (resolveBooleanCondition(
                      expression: Expression.fromMap(itemDef['condition'])) ==
                  false))) {
        dynamic tempItems =
            renderedGroup['items'].where((iter) => iter['key'] != item['key']);
        renderedGroup['items'] = tempItems.toList();
        return;
      }

      currentIndex = null;
      for (int iter = 0; iter < renderedGroup['items'].length; iter++) {
        if (renderedGroup['items'][iter]['key'] == item['key']) {
          currentIndex = iter;
          break;
        }
      }
      if (currentIndex == null) {
        Warning(message: "index not found for $item to insert");
        return;
      }
      if (item['items'] != null) {
        renderedGroup['items'][currentIndex] = reRenderGroup(item);
      } else {
        renderedGroup['items'][currentIndex] =
            renderSurveySingleItem(SurveySingleItem.fromMap(itemDef));
        print("RERENDER SURVEY ITEM:" + itemDef['key']);
      }

      dynamic nextItem =
          getNextItem(groupDef, renderedGroup, item['key'], true);
      while (nextItem != null) {
        currentIndex++;
        if (nextItem['items'] == null) {
          dynamic rendered =
              renderSurveySingleItem(SurveySingleItem.fromMap(nextItem));
          renderedGroup['items'].insert(currentIndex, rendered);
          updateResponseItem(
              responseGroup: this.responses,
              changeKey: nextItem['key'],
              timeStampType: 'rendered');
        } else {
          renderedGroup['items'].insert(currentIndex,
              initRenderedGroupItem(SurveyGroupItem.fromMap(nextItem)));
        }
        nextItem = getNextItem(groupDef, renderedGroup, nextItem.key, true);
      }
    });

    dynamic lastItem =
        renderedGroup['items'][renderedGroup['items'].length - 1];
    nextItem = getNextItem(groupDef, renderedGroup, lastItem['key'], false);
    while (nextItem != null) {
      if (nextItem['items'] == null) {
        dynamic rendered =
            renderSurveySingleItem(SurveySingleItem.fromMap(nextItem));
        renderedGroup['items'].add(rendered);
        updateResponseItem(
            responseGroup: this.responses,
            changeKey: nextItem['key'],
            timeStampType: 'rendered');
      } else {
        renderedGroup['items']
            .add(initRenderedGroupItem(SurveyGroupItem.fromMap(nextItem)));
      }
      nextItem = getNextItem(groupDef, renderedGroup, nextItem['key'], false);
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
    ExpressionEvaluation eval = ExpressionEvaluation(
        context: this.context,
        renderedSurvey: this.renderedSurvey,
        responses: this.responses);
    Map<Object, Object> propertiesMap = {
      'min': eval.evaluateArgument(
        props.min,
      ),
      'max': eval.evaluateArgument(
        props.max,
      ),
      'stepSize': eval.evaluateArgument(
        props.stepSize,
      )
    };
    return Utils.removeNullParams(propertiesMap);
  }

  List<Map<String, Object>> resolveContent(List<LocalizedString> content) {
    if (content == null) return null;
    List<Map<String, Object>> resolvedContent = [];
    content.forEach((localizedObject) {
      Map<String, Object> resolvedLocalisedObject =
          Utils.getResolvedLocalisedObject(
        localizedObject,
        context: this.context,
        renderedSurvey: this.renderedSurvey,
        responses: this.responses,
      );
      resolvedContent.add(Utils.removeNullParams(resolvedLocalisedObject));
    });
    return resolvedContent;
  }

  dynamic resolveItemComponentGroup(
      ItemGroupComponent component, SurveySingleItem parentItem) {
    if (component == null) return null;
    var resolvedGroup = component.toMap();
    resolvedGroup['items'] = [];
    // Resolve Group

    resolvedGroup['displayCondition'] = resolveBooleanCondition(
        expression: component.displayCondition,
        nullValue: true,
        temporaryItem: parentItem);
    resolvedGroup['content'] = resolveContent(component.content);
    resolvedGroup['description'] = resolveContent(component.description);
    // By default disabled
    resolvedGroup['disabled'] = resolveBooleanCondition(
        expression: component.disabled,
        nullValue: false,
        temporaryItem: parentItem);
    // Weed removal is only used for testing /comparing JSON from survey-engine.ts
    // By default undefined vars in survey-engine.ts are not taken in the output however survey engine.dart renders with default
    // values. This block will be removed after full stack is developed.
    if (this.weedRemoval == true) {
      if (resolvedGroup['disabled'] == false) {
        resolvedGroup['disabled'] = null;
      }
      if (resolvedGroup['displayCondition'] == true) {
        resolvedGroup['displayCondition'] = null;
      }
    }

    // Resolve items

    component.items.forEach((itemComponent) {
      if (itemComponent.items == null) {
        dynamic resolvedItemComponent = itemComponent.toMap();
        resolvedItemComponent['displayCondition'] = resolveBooleanCondition(
            expression: itemComponent.displayCondition,
            nullValue: true,
            temporaryItem: parentItem);
        resolvedItemComponent['content'] =
            resolveContent(itemComponent.content);
        resolvedItemComponent['description'] =
            resolveContent(itemComponent.description);
        // By default disabled
        resolvedItemComponent['disabled'] = resolveBooleanCondition(
            expression: itemComponent.disabled,
            nullValue: false,
            temporaryItem: parentItem);
        // Weed removal is only used for testing /comparing JSON from survey-engine.ts
        // By default undefined vars in survey-engine.ts are not taken in the output however survey engine.dart renders with default
        // values. This block will be removed after full stack is developed.
        if (this.weedRemoval == true) {
          if (resolvedItemComponent['disabled'] == false) {
            resolvedItemComponent['disabled'] = null;
          }
          if (resolvedItemComponent['dtype'] == 'string') {
            resolvedItemComponent['dtype'] = null;
          }
          if (resolvedItemComponent['displayCondition'] == true) {
            resolvedItemComponent['displayCondition'] = null;
          }
        }
        resolvedItemComponent['properties'] =
            resolveItemComponentProperties(itemComponent.properties);
        resolvedGroup['items']
            .add(Utils.removeNullParams(resolvedItemComponent));
      } else {
        resolvedGroup['items'].add(Utils.removeNullParams(
            resolveItemComponentGroup(itemComponent, parentItem)));
      }
    });
    return Utils.removeNullParams(resolvedGroup);
  }

// Rendering Survey Group Items
  dynamic renderSurveySingleItem(SurveySingleItem surveySingleItem) {
    if (surveySingleItem == null) {
      return null;
    }
    dynamic renderedItem = surveySingleItem.toMap();
    // renderedItem['condition'] = resolveBooleanCondition(
    //     expression: Expression.fromMap(renderedItem['condition']),
    //     nullValue: true);
    List<Map<String, Object>> renderedValidations = [];
    surveySingleItem.validations?.forEach((validation) {
      Map<String, Object> validationMap = validation.toMap();
      validationMap['rule'] =
          resolveBooleanCondition(expression: validation.rule);
      renderedValidations.add(validationMap);
    });
    renderedItem['components'] = resolveItemComponentGroup(
        surveySingleItem.components, surveySingleItem);
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
              resolveBooleanCondition(
                  expression: Expression.fromMap(item['condition']))));
    }).toList();
    return unRenderedItems;
  }

  dynamic getNextItem(SurveyGroupItem surveyGroupItem,
      dynamic renderedParentGroup, String lastKey, bool onlyDirectFollower) {
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
      Warning(message: itemId + ": not found");
      return null;
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
        Warning(message: itemId + ": not found");
        result = null;
        return;
      } else
        result = foundItem;
    });
    return result;
  }

  SurveyItem findSurveyItem(String itemId, {SurveyItem rootItem}) {
    if (itemId == null) return null;
    SurveyItem root = rootItem ?? this.surveyDef;
    if (Utils.getRootKey(root.key) != Utils.getRootKey(itemId)) {
      Warning(message: itemId + ": not found");
      return null;
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
        Warning(message: itemId + ": not found");
        result = null;
        return;
      } else
        result = foundItem;
    });
    return result;
  }

  // Update trees
  SurveyGroupItemResponse updateResponseItem(
      {SurveyGroupItemResponse responseGroup,
      ResponseItem newResponseItem,
      String changeKey,
      String timeStampType}) {
    if (responseGroup == null || changeKey == null || timeStampType == null)
      return null;
    if (responseGroup.key == changeKey) {
      responseGroup = setTimestampFor(timeStampType, responseGroup);
      return responseGroup;
    }
    SurveyGroupItemResponse iterResponseGroup = SurveyGroupItemResponse(
        key: responseGroup.key, items: [], meta: responseGroup.meta);
    for (final item in responseGroup.items) {
      if (item.key == changeKey) {
        SurveyItemResponse response;
        if (item.items == null && newResponseItem != null) {
          response = SurveySingleItemResponse(
              key: item.key, meta: item.meta, response: newResponseItem);
          response = setTimestampFor(timeStampType, response);
        } else {
          response = setTimestampFor(timeStampType, item);
        }
        iterResponseGroup.items.add(response);
        continue;
      }
      if (item.items == null) {
        SurveyItemResponse response = item;
        iterResponseGroup.items.add(response);
      } else {
        iterResponseGroup.items.add(updateResponseItem(
            responseGroup: item,
            newResponseItem: newResponseItem,
            changeKey: changeKey,
            timeStampType: timeStampType));
      }
    }
    return iterResponseGroup;
  }

  bool resolveBooleanCondition(
      {Expression expression, SurveySingleItem temporaryItem, bool nullValue}) {
    return Utils.evaluateBooleanResult(expression,
        context: this.context,
        renderedSurvey: this.renderedSurvey,
        responses: this.responses,
        temporaryItem: temporaryItem,
        nullValue: nullValue);
  }

  dynamic resolveExpression(
      {Expression expression, SurveySingleItem temporaryItem}) {
    ExpressionEvaluation eval = ExpressionEvaluation(
        context: this.context,
        renderedSurvey: this.renderedSurvey,
        responses: this.responses,
        temporaryItem: temporaryItem);
    return eval.evalExpression(expression: expression);
  }
}

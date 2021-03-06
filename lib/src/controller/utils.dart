import 'dart:math';

import 'package:influenzanet_survey_engine/src/controller/expression_eval.dart';
import 'package:influenzanet_survey_engine/src/models/constants.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression_arg.dart';
import 'package:influenzanet_survey_engine/src/models/expression/expression_arg_dtype.dart';
import 'package:influenzanet_survey_engine/src/models/localized_object/localized_string.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_context.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item/survey_single_item.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item_response/survey_group_item_response.dart';
import 'package:influenzanet_survey_engine/src/models/survey_item_response/survey_single_item_response.dart';

class Warning {
  String message;
  Warning({
    this.message,
  }) {
    print("Warning: $message");
  }
}

class SelectionMethods {
  static dynamic pickAnItem({List<dynamic> items, Expression expression}) {
    if (expression == null) {
      return sequential(items);
    }
    switch (expression.name) {
      case 'uniform':
        return uniform(items);
      case 'highestPriority':
        return highestPriority(items);
      case 'exponential':
        return exponential(items, expression);
    }
  }

  static dynamic sequential(List<dynamic> items) {
    return items[rootItem];
  }

  static dynamic uniform(List<dynamic> items) {
    final _random = new Random();
    return items[_random.nextInt(items.length)];
  }

  static dynamic highestPriority(List<dynamic> items) {
    items = sortByPriority(items);
    return items[firstArgument];
  }

  static List<dynamic> sortByPriority(List<dynamic> items) {
    items.sort((a, b) => b['priority'] - a['priority']);
    return items;
  }

  static dynamic exponential(List<dynamic> items, Expression expression) {
    // TO DO: the function has been directly picked from survey-engine.ts needs a bit of understanding
    // and probably a little re-work
    if (items.length < 1 ||
        expression == null ||
        expression.data == null ||
        expression.data.length != 1) {}
    if (expression.data[firstArgument].number == null) {}

    var rate = expression.data[firstArgument].number;
    var scaling = -log(0.002) / rate;

    List<dynamic> sorted = sortByPriority(items);
    Random random = new Random();
    var uniform = random.nextInt(1);

    var exp = (-1 / rate) * log(uniform) / scaling;
    if (exp > 1) {
      exp = 1;
    }
    var index = (exp * items.length).floor();
    if (index >= items.length) {
      index = items.length - 1;
    }
    return sorted[index];
  }
}

class Utils {
  // Survey model specific functions
  static bool evaluateBooleanResult(Expression expression,
      {bool nullValue,
      SurveyContext context,
      dynamic renderedSurvey,
      SurveyGroupItemResponse responses,
      SurveySingleItem temporaryItem}) {
    ExpressionEvaluation eval = ExpressionEvaluation();
    // Display condition must always be of boolean type
    if (expression == null) {
      return nullValue ?? true;
    }
    // if (expression?.returnType != 'boolean') {
    //   return false;
    // }
    return eval.evalExpression(
        expression: expression,
        context: context,
        renderedSurvey: renderedSurvey,
        responses: responses,
        temporaryItem: temporaryItem);
  }

  static String getRootKey(String key) {
    return key.split(keyHierarchySeperator)[rootItem];
  }

  static List<ExpressionArg> resolveParts(List<ExpressionArg> parts,
      {SurveyContext context,
      dynamic renderedSurvey,
      SurveyGroupItemResponse responses,
      SurveySingleItem temporaryItem}) {
    parts?.forEach((expressionArg) {
      // In case of expression evaluate the expression as String
      if (expressionArg.exprArgDType.dtype == 'exp') {
        ExpressionEvaluation eval = ExpressionEvaluation();
        expressionArg.str = eval
            .evalExpression(
                expression: expressionArg.exp,
                context: context,
                renderedSurvey: renderedSurvey,
                responses: responses,
                temporaryItem: temporaryItem)
            .toString();
      } else {
        expressionArg.exprArgDType = ExpressionArgDType(dtype: 'str');
      }
    });
    return parts;
  }

  static Map<String, Object> getResolvedLocalisedObject(
      LocalizedString localizedObject,
      {SurveyContext context,
      dynamic renderedSurvey,
      SurveyGroupItemResponse responses,
      SurveySingleItem temporaryItem}) {
    List<String> localisedString = [];
    Utils.resolveParts(localizedObject.parts,
        context: context,
        renderedSurvey: renderedSurvey,
        responses: responses,
        temporaryItem: temporaryItem);
    localizedObject.parts.forEach((expressionArg) {
      localisedString.add(expressionArg.str);
    });
    Map<String, Object> resolvedParts = {
      'code': localizedObject.code,
      'parts': localisedString
    };
    return resolvedParts;
  }

  static List<dynamic> getFlattenedSurveyResponses(
      SurveyGroupItemResponse questionGroup,
      {String parentKey}) {
    if (questionGroup == null) return null;
    dynamic flatResponseList = [];
    for (final item in questionGroup.items) {
      if (item is SurveySingleItemResponse) {
        SurveySingleItemResponse response =
            SurveySingleItemResponse.fromMap(item.toMap());
        flatResponseList.add(response.toMap());
      } else {
        flatResponseList.addAll(getFlattenedSurveyResponses(item));
      }
    }
    return flatResponseList.toList();
  }

  static List<dynamic> getFlattenedRenderedSurvey(dynamic questionGroup,
      {String parentKey}) {
    if (questionGroup == null) return null;
    dynamic flatRenderedList = [];
    for (final item in questionGroup['items']) {
      if (item['items'] == null) {
        flatRenderedList.add(item);
      } else {
        flatRenderedList.addAll(getFlattenedRenderedSurvey(item));
      }
    }
    return flatRenderedList.toList();
  }

  // General functions
  static dynamic resolveNullList(dynamic nullCheck) {
    return (nullCheck == null)
        ? null
        : List<dynamic>.from(nullCheck?.map((item) => item));
  }

  static dynamic resolveNullListOfMaps(dynamic nullCheck) {
    return (nullCheck == null)
        ? null
        : List<dynamic>.from(nullCheck?.map((item) => item?.toMap()));
  }

  static List<String> removeNullString(List<String> list) {
    if (list == null) return [];
    List<String> cur = [];
    list.forEach((item) {
      if (item != null) cur.add(item);
    });
    return cur;
  }

  static List removeNullItems(List list) {
    if (list == null) return [];
    list.removeWhere((item) => item == null);
    return list;
  }

  static dynamic removeNullParams(dynamic map) {
    var keys = map.keys.toList(growable: false);
    for (String key in keys) {
      var value = map[key];
      if (value == null) {
        map.remove(key);
      } else if (value is Map) {
        map[key] = removeNullParams(value);
      } else if (value is List) {
        // This is a workaround for List<String> not subtype of List<Dynamic> and needs cleaning later
        if (removeArrayStrings.contains(key)) {
          value = removeNullString(value);
          continue;
        }
        int index = 0;
        value = removeNullItems(value);
        map[key] = value;
        value.forEach((item) {
          if (item is Map) {
            var m = removeNullParams(item);
            map[key][index] = m;
          }
          index++;
        });
      }
    }
    return map;
  }

  static dynamic parseExpressionReturnType({dynamic item, String returnType}) {
    if (item == null || returnType == null) {
      return null;
    }
    switch (returnType) {
      case 'int':
        return (item is String) ? int.parse(item) : item;
      case 'float':
        return (item is String) ? double.parse(item) : item;
      case 'string':
        return (item is String) ? item : item.toString();
      default:
        Warning(message: "$item: Cannot parse return type");
        return item;
    }
  }
}

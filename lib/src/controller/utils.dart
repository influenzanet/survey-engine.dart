import 'dart:math';

import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg_dtype.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';

class SelectionMethods {
  static dynamic pickAnItem({List<dynamic> items, Expression expression}) {
    if (expression == null) {
      return uniform(items);
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
    // TO DO: the function has been directly picked from survey-engine.ts needs a bit bit of understanding
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
  static List<ExpressionArg> resolveParts(List<ExpressionArg> parts) {
    parts?.forEach((expressionArg) {
      // In case of expression evaluate the expression as String
      if (expressionArg.exprArgDType.dtype == 'exp') {
        ExpressionEvaluation eval = ExpressionEvaluation();
        expressionArg.str =
            eval.evalExpression(expression: expressionArg.exp).toString();
      } else {
        expressionArg.exprArgDType = ExpressionArgDType(dtype: 'str');
      }
    });
    return parts;
  }

  static String getLocalisedString(LocalizedObject localizedObject) {
    String localisedString = '';
    localizedObject.parts.forEach((expressionArg) {
      localisedString = localisedString + (expressionArg.str);
    });
    return localisedString;
  }

  static dynamic removeNullParams(dynamic mapToEdit) {
    var keys = mapToEdit.keys.toList(growable: false);
    for (String key in keys) {
      var value = mapToEdit[key];
      if (value == null) {
        mapToEdit.remove(key);
      } else if (value is Map) {
        mapToEdit[key] = removeNullParams(value);
      } else if (value is List) {
        List valueList = [];
        value.forEach((item) {
          if (item is Map) {
            item = removeNullParams(item);
          }
          valueList.add(item);
        });
        mapToEdit[key] = valueList;
      }
    }
    return mapToEdit;
  }
}

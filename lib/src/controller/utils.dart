import 'dart:math';

import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg_dtype.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';

class SelectionMethods {
  static dynamic pickAnItem({List<dynamic> items, String method}) {
    switch (method) {
      case 'uniform':
        return uniform(items);
      case 'highestPriority':
        return highestPriority(items);
      case 'exponential':
        return exponential(items);
      default:
        print('Wrong selection method defaulting to random');
        return uniform(items);
    }
  }

  static dynamic uniform(List<dynamic> items) {
    final _random = new Random();
    return items[_random.nextInt(items.length)];
  }

  static dynamic highestPriority(List<dynamic> items) {
    items.sort((a, b) => b['priority'] - a['priority']);
    return items[firstArgument];
  }

  static dynamic exponential(List<dynamic> items) {
    // Todo: Implement exponential after confirming on the function
  }
}

class Utils {
  static List<ExpressionArg> resolveContent(List<ExpressionArg> parts) {
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
    List<String> localisedString = [];
    localizedObject.parts.forEach((expressionArg) {
      localisedString.add(expressionArg.str);
    });
    return localisedString.join();
  }
}

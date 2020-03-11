import 'dart:math';

import 'package:survey_engine.dart/src/models/constants.dart';

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

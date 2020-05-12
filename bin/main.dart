import 'dart:collection';
import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';

const testSurveySingleItemOne = {'key': 'G0.S1'};
const testSurveySingleItemOneGrpTwo = {'key': 'G0.G1.S1'};
const testSurveySingleItemThreeGrpTwo = {'key': 'G0.G1.S2'};
const testSurveySingleItemTwo = {'key': 'G0.S2'};
const testSurveyGroupItemOne = {
  'key': 'G0.G1',
  'items': [testSurveySingleItemOneGrpTwo, testSurveySingleItemThreeGrpTwo]
};
const testSurveyGroupItemResult = {
  'key': 'G0',
  'items': [
    testSurveySingleItemOne,
    testSurveySingleItemTwo,
    testSurveyGroupItemOne
  ]
};

abstract class Item {
  String key;
  List<Item> items;
  factory Item(Map<String, dynamic> map) {
    // SingleItem does not have an items List
    if (map['items'] == null) {
      return SingleItem.fromMap(map);
    } else {
      return GroupItem.fromMap(map);
    }
  }
  Map<String, dynamic> toMap();
  String toJson();
}

class GroupItem implements Item {
  String key;
  List<Item> items;
  GroupItem({
    this.key,
    this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'items': List<dynamic>.from(items.map((x) => x.toMap())),
    };
  }

  static GroupItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    var temp = map['items']?.map((x) => Item(x));
    var tempData = List<Item>.from(temp);
    return GroupItem(
      key: map['key'],
      items: tempData,
    );
  }

  String toJson() => json.encode(HashMap.from(toMap()));

  static GroupItem fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'GroupItem(key: $key, items: $items)';
}

class SingleItem implements Item {
  String key;
  List<Item> items;
  SingleItem({
    this.key,
  });

  Map<String, dynamic> toMap() {
    return {'key': key};
  }

  static SingleItem fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SingleItem(key: map['key']);
  }

  String toJson() => json.encode(HashMap.from(toMap()));

  static SingleItem fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'SingleItem(key: $key, items: $items)';
}

Item findItem(String itemID) {
  if (itemID == testSurveyGroupItemResult['key']) {
    return Item(testSurveyGroupItemResult);
  }
  String compID = testSurveyGroupItemResult['key'];
  Item obj = Item(testSurveyGroupItemResult);
  List<String> ids = itemID.split('.').sublist(1);
  ids.forEach((id) {
    if (!(obj is GroupItem)) {
      return;
    }
    compID = compID + '.' + id;
    Item foundItem =
        obj.items.firstWhere((item) => item.key == compID, orElse: () => null);
    if (foundItem == null) {
      throw InvalidTimestampException(message: 'Not found');
    } else
      obj = foundItem;
  });
  return obj;
}

void main() {
  GroupItem actual = GroupItem.fromMap(testSurveyGroupItemResult);
  print(actual.toMap());
  var x = findItem('G0');
  print(x.toMap());
}

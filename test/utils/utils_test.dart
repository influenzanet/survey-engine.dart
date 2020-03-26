import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:test/test.dart';

void main() {
  group(
      'Test resolution of null parameters to return null of the cheking variable is null or resolve otherwise :\n',
      () {
    setUp(() {});
    test('Check if `null` is returned on nullCheck=`null`', () {
      expect(Utils.resolveNullList(null), isNull);
    });

    test(
        'Check if a list of dynamic items is sent it returns the List of map of the dynamic list',
        () {
      expect(Utils.resolveNullList([1, 2, 3]), [1, 2, 3]);
    });
  });

  group('Test removal of null parameters from a map :\n', () {
    var simpleMap;
    var nestedMap;
    var listMap;

    setUp(() {
      simpleMap = {'key1': 'val1', 'key2': null};
      nestedMap = {
        'mainKey': {'key1': 'val1', 'key2': null},
        'nullKey': null
      };
      listMap = {
        'listItem': [
          {
            'mainKey': {'key1': 'val1', 'key2': null},
            'nullKey': null
          },
          null,
          1,
        ],
      };
    });
    test('Check if `null` is removed from simple key value pair', () {
      expect(Utils.removeNullParams(simpleMap), {'key1': 'val1'});
    });
    test('Check if `null` is removed from nested key value pairs', () {
      expect(
          Utils.removeNullParams(nestedMap).toString(),
          {
            'mainKey': {'key1': 'val1'}
          }.toString());
    });
    test('Check if `null` is removed from list of key value pairs', () {
      expect(
          Utils.removeNullParams(listMap).toString(),
          {
            'listItem': [
              {
                'mainKey': {'key1': 'val1'}
              },
              1
            ]
          }.toString());
    });
  });
}

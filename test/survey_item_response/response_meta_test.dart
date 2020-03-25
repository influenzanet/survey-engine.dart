import 'dart:convert';

import 'package:survey_engine.dart/src/models/survey_item_response/responseMeta.dart';
import 'package:test/test.dart';

void main() {
  group('Response Meta object tests:\n', () {
    setUp(() {});

    test('Test default metaObject returns a valid map :\n', () {
      Map<String, Object> expected = {
        'position': -1,
        'localeCode': '',
        'version': null,
        'rendered': [],
        'displayed': [],
        'responded': []
      };
      ResponseMeta actual = ResponseMeta();
      print('Expected = $expected \n Actual = $actual');
      expect(actual.toJson(), json.encode(expected));
    });
    test('Test metaObject creation returns a valid map :\n', () {
      // TO DO: Write test for a valid timestamp after string conversion clarification
      ResponseMeta expected = ResponseMeta.fromMap({
        'position': 1,
        'localeCode': 'someCode',
        'version': 1,
        'rendered': [1, 2],
        'displayed': [1, 2],
        'responded': [1, 2]
      });
      ResponseMeta actual = ResponseMeta(
          position: 1,
          localeCode: 'someCode',
          version: 1,
          rendered: [1, 2],
          displayed: [1, 2],
          responded: [1, 2]);
      print('Expected = $expected \n Actual = $actual');
      expect(actual.toJson(), expected.toJson());
    });
  });
}

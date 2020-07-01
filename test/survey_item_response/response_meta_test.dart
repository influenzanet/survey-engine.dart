import 'dart:collection';
import 'dart:convert';

import 'package:influenzanet_survey_engine/src/models/survey_item_response/response_meta.dart';
import 'package:test/test.dart';

void main() {
  group('Response Meta object tests:\n', () {
    setUp(() {});

    test('Test default metaObject returns a valid map :\n', () {
      Map<String, Object> expected = {
        'position': -1,
        'localeCode': '',
        'rendered': [],
        'displayed': [],
        'responded': []
      };
      ResponseMeta actual = ResponseMeta();
      print('Expected = $expected \n Actual = $actual');
      expect(actual.toJson(), json.encode(HashMap.from(expected)));
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

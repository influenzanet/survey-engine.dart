import 'package:survey_engine.dart/src/models/survey_item_response/response_item.dart';
import 'package:test/test.dart';

void main() {
  group('Response Item object creation init tests:\n', () {
    Map<String, Object> testResponseItem;

    setUp(() {
      testResponseItem = {
        'key': 'RG1',
        'items': [
          {'key': 'RG1.R1', 'value': "something", 'dtype': 'str'}
        ],
        'value': "14",
        'dtype': 'num',
      };
    });

    test('Test a sample valid response item  with a value:14 of num type', () {
      ResponseItem item =
          ResponseItem(key: 'RG1.R1', value: "something", dtype: 'str');
      ResponseItem expected =
          ResponseItem(dtype: 'num', items: [item], key: 'RG1', value: '14');
      ResponseItem actual = ResponseItem.fromMap(testResponseItem);
      print('$expected \n $actual');
      expect(actual.toJson(), expected.toJson());
    });
  });
}

import 'package:survey_engine.dart/src/models/item_component/display_component.dart';
import 'package:survey_engine.dart/src/models/item_component/item_component.dart';
import 'package:test/test.dart';

void main() {
  group('Item Component object creation init tests:\n', () {
    Map<String, Object> testItemComponentMap;

    setUp(() {
      testItemComponentMap = {
        'role': 'title',
        'content': [
          {
            'code': 'en',
            'parts': [
              {'str': 'Invalid input data'},
            ]
          },
        ],
      };
    });

    test('Test ItemComponent creation with DisplayComponent Roles', () {
      DisplayComponent expected =
          DisplayComponent.fromMap(testItemComponentMap);
      ItemComponent actual = ItemComponent(testItemComponentMap);
      expect(actual.jsonValue, expected.jsonValue);
    });
  });
}

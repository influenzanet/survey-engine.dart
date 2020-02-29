import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/item_component/display_component.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';
import 'package:test/test.dart';

void main() {
  group('Display Item Component object creation init tests:\n', () {
    Map<String, dynamic> testLocalisedObjectMap;
    Map<String, Object> testDisplayItemComponentMap;

    setUp(() {
      testDisplayItemComponentMap = {
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

    test('Test role title creation with ', () {
      testLocalisedObjectMap = {
        'code': 'en',
        'parts': [
          {'str': 'Invalid input data'},
        ]
      };
      LocalizedObject localisedObject =
          LocalizedObject.fromMap(testLocalisedObjectMap);
      DisplayComponent expected =
          DisplayComponent(role: 'title', content: [localisedObject]);
      DisplayComponent actual =
          DisplayComponent.fromMap(testDisplayItemComponentMap);
      expect(actual.toJson(), expected.toJson());
    });

    test(
        'Test invalid role :`bubble` in DisplayComponent creation throws exception ',
        () {
      testDisplayItemComponentMap = {
        'role': 'bumble',
        'content': [
          {
            'code': 'en',
            'parts': [
              {'str': 'Invalid role'},
            ]
          },
        ],
      };
      expect(() => DisplayComponent.fromMap(testDisplayItemComponentMap),
          throwsA(TypeMatcher<InvalidRoleException>()));
    });
  });
}

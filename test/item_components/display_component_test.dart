import 'package:influenzanet_survey_engine/src/controller/exceptions.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/display_component.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/style_component.dart';
import 'package:influenzanet_survey_engine/src/models/localized_object/localized_string.dart';
import 'package:test/test.dart';

void main() {
  group('Display Item Component object creation init tests:\n', () {
    Map<String, dynamic> testLocalisedObjectMap;
    Map<String, Object> testDisplayItemComponentMap;

    setUp(() {
      testDisplayItemComponentMap = {
        'role': 'title',
        'style': [
          {'key': 'variant', 'value': 'annotation'}
        ],
        'content': [
          {
            'code': 'en',
            'parts': [
              {'str': 'Some input data'},
            ]
          },
        ],
      };
    });

    test('Test role title creation with LocalisedObject', () {
      testLocalisedObjectMap = {
        'code': 'en',
        'parts': [
          {'str': 'Some input data'},
        ]
      };
      LocalizedString localisedObject =
          LocalizedString.fromMap(testLocalisedObjectMap);
      DisplayComponent expected = DisplayComponent(role: 'title', content: [
        localisedObject
      ], style: [
        Style.fromMap({'key': 'variant', 'value': 'annotation'})
      ]);
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
          throwsA(TypeMatcher<MapCreationException>()));
    });
  });
}

import 'package:influenzanet_survey_engine/src/controller/exceptions.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/response_component.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/style_component.dart';
import 'package:influenzanet_survey_engine/src/models/localized_object/localized_string.dart';
import 'package:test/test.dart';

void main() {
  group('Response Item Component object creation init tests:\n', () {
    Map<String, dynamic> testLocalisedObjectMap;
    Map<String, Object> testResponseComponentMap;

    setUp(() {
      testResponseComponentMap = {
        'role': 'input',
        'style': [
          {'key': 'variant', 'value': 'annotation'}
        ],
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

    test('Test role input creation with LocalisedObject', () {
      testLocalisedObjectMap = {
        'code': 'en',
        'parts': [
          {'str': 'Invalid input data'},
        ]
      };
      LocalizedString localisedObject =
          LocalizedString.fromMap(testLocalisedObjectMap);
      ResponseComponent expected = ResponseComponent(role: 'input', content: [
        localisedObject
      ], style: [
        Style.fromMap({'key': 'variant', 'value': 'annotation'})
      ]);
      ResponseComponent actual =
          ResponseComponent.fromMap(testResponseComponentMap);
      expect(actual.toJson(), expected.toJson());
    });

    test(
        'Test invalid role :`bubble` in ResponseComponent creation throws exception ',
        () {
      testResponseComponentMap = {
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
      expect(() => ResponseComponent.fromMap(testResponseComponentMap),
          throwsA(TypeMatcher<MapCreationException>()));
    });
  });
}

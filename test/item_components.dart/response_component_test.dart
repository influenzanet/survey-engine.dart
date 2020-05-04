import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/item_component/response_component.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';
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
      LocalizedObject localisedObject =
          LocalizedObject.fromMap(testLocalisedObjectMap);
      ResponseComponent expected = ResponseComponent(role: 'input', content: [
        localisedObject
      ], style: [
        {'key': 'variant', 'value': 'annotation'}
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
          throwsA(TypeMatcher<InvalidRoleException>()));
    });
  });
}

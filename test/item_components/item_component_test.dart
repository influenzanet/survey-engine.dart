import 'package:influenzanet_survey_engine/src/models/item_component/display_component.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/item_component.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/item_group_component.dart';
import 'package:influenzanet_survey_engine/src/models/item_component/response_component.dart';
import 'package:test/test.dart';

void main() {
  group('Item Component object creation init tests:\n', () {
    setUp(() {});

    test('Test ItemComponent creation with DisplayComponent Roles', () {
      const List<String> rolesTest = ['title', 'text', 'warning', 'error'];
      Iterable<Map<String, Object>> testDisplayComponentList =
          rolesTest.map((role) => {
                'role': role,
                'content': [
                  {
                    'code': 'en',
                    'parts': [
                      {'str': 'Some input data'},
                    ]
                  },
                ],
              });
      testDisplayComponentList.forEach((component) {
        DisplayComponent expected = DisplayComponent.fromMap(component);
        ItemComponent actual = ItemComponent(component);
        expect(actual.toJson(), expected.toJson());
      });
    });

    test('Test ItemComponent creation with ResponseComponent Roles', () {
      const List<String> rolesTest = [
        'option',
        'input',
        'multilineTextInput',
        'numberInput',
        'dateInput'
      ];
      Iterable<Map<String, Object>> testResponseComponentList =
          rolesTest.map((role) => {
                'role': role,
                'content': [
                  {
                    'code': 'en',
                    'parts': [
                      {'str': 'Some input data'},
                    ]
                  },
                ],
              });
      testResponseComponentList.forEach((component) {
        ResponseComponent expected = ResponseComponent.fromMap(component);
        ItemComponent actual = ItemComponent(component);
        expect(actual.toJson(), expected.toJson());
      });
    });

    test('Test ItemComponent creation with ItemGroupComponent Roles', () {
      const List<String> rolesTest = [
        'root',
        'helpGroup',
        'responseGroup',
        'singleChoiceGroup',
        'multipleChoiceGroup',
        'dropDownGroup'
      ];
      Iterable<Map<String, Object>> testItemGroupComponentList =
          rolesTest.map((role) => {
                'role': role,
                'style': [
                  {'key': 'variant', 'value': 'annotation'}
                ],
                'items': [
                  {
                    'role': 'input',
                    'content': [
                      {
                        'code': 'en',
                        'parts': [
                          {'str': 'Some input data'},
                        ]
                      },
                    ],
                  },
                ],
              });
      testItemGroupComponentList.forEach((component) {
        ItemGroupComponent expected = ItemGroupComponent.fromMap(component);
        ItemComponent actual = ItemComponent(component);
        expect(actual.toJson(), expected.toJson());
      });
    });
  });
}

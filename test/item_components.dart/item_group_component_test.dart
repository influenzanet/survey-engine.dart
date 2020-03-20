import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/constants.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/display_component.dart';
import 'package:survey_engine.dart/src/models/item_component/item_group_component.dart';
import 'package:survey_engine.dart/src/models/item_component/response_component.dart';
import 'package:test/test.dart';

void main() {
  group('Response Item Group Component object creation init tests:\n', () {
    Map<String, dynamic> testItemGroupComponentMap;
    Map<String, Object> testResponseComponentMap, testDisplayItemComponentMap;

    setUp(() {
      testResponseComponentMap = {
        'role': 'input',
        'content': [
          {
            'code': 'en',
            'parts': [
              {'str': 'Some input data'},
            ]
          },
        ],
      };
      testDisplayItemComponentMap = {
        'role': 'title',
        'content': [
          {
            'code': 'en',
            'parts': [
              {'str': 'Some title data'},
            ]
          },
        ],
      };
      testItemGroupComponentMap = {
        'role': 'root',
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
          {
            'role': 'title',
            'content': [
              {
                'code': 'en',
                'parts': [
                  {'str': 'Some title data'},
                ]
              },
            ],
          }
        ]
      };
    });

    test(
        'Test item group component creation with an item list containing a response and a display component ',
        () {
      ExpressionEvaluation eval = ExpressionEvaluation();
      ResponseComponent responseComponent =
          ResponseComponent.fromMap(testResponseComponentMap);
      ItemGroupComponent actual =
          ItemGroupComponent.fromMap(testItemGroupComponentMap);
      DisplayComponent displayComponent =
          DisplayComponent.fromMap(testDisplayItemComponentMap);
      expect(actual.role, 'root');
      expect(
          actual.items.toString(),
          eval
              .evalExpression(
                  expression: Expression(name: 'sequential'),
                  items: actual.items)
              .toString());
      expect(actual.items[firstComponent].toJson(), responseComponent.toJson());
      expect(actual.items[secondComponent].toJson(), displayComponent.toJson());
    });
  });
}

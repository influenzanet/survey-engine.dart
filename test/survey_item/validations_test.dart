import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/survey_item/validations.dart';
import 'package:test/test.dart';

void main() {
  group('Validation object creation init tests:\n', () {
    Map<String, Object> expression;
    Map<String, Object> testValidation;

    setUp(() {
      expression = {
        'name': 'or',
        'returnType': 'boolean',
        'data': [
          {'dType': 'boolean', 'boolean': 'true'}
        ]
      };
      testValidation = {
        'type': 'soft',
        'key': 'v1',
        'rule': {
          'name': 'or',
          'data': [
            {'dType': 'boolean', 'boolean': 'true'}
          ]
        }
      };
    });

    test(
        'Testing a Validation with no returnType in expression (must default to `boolean` check)',
        () {
      Validations expected = Validations(
          key: 'v1', type: 'soft', rule: Expression.fromMap(expression));
      Validations actual = Validations.fromMap(testValidation);

      expect(actual.toJson(), expected.toJson());
    });

    test(
        'Testing a Validation with an invalid validation `medium` causes an exception',
        () {
      expect(
          () => Validations(
              key: 'v1', type: 'medium', rule: Expression.fromMap(expression)),
          throwsA(TypeMatcher<InvalidValidationException>()));
    });
  });
}

import 'package:survey_engine.dart/src/controller/engine_core.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg.dart';
import 'package:survey_engine.dart/src/models/expression/expression_arg_dtype.dart';
import 'package:survey_engine.dart/src/models/item_component/properties.dart';
import 'package:test/test.dart';

void main() {
  group('Resolve Component properties test:\n', () {
    Map<String, Map<String, Object>> testProperties;
    setUp(() {
      testProperties = {
        'min': {
          'dtype': 'num',
          'num': -5,
        },
        'max': {
          'dtype': 'num',
          'num': 5,
        },
        'stepSize': {
          'dtype': 'num',
          'num': 5,
        }
      };
    });
    test('Test Properties object creation', () {
      Properties actual = Properties.fromMap(testProperties);
      Properties expected = Properties(
          min: ExpressionArg(
              exprArgDType: ExpressionArgDType(dtype: 'num'), number: -5),
          max: ExpressionArg(
              exprArgDType: ExpressionArgDType(dtype: 'num'), number: 5),
          stepSize: ExpressionArg(
              exprArgDType: ExpressionArgDType(dtype: 'num'), number: 5));
      expect(actual.toJson(), expected.toJson());
    });

    test(
        'Test values of min,max and stepSize on resolving the Component properties',
        () {
      SurveyEngineCore surveyEngineCore = new SurveyEngineCore();
      Properties sampleProps = Properties.fromMap(testProperties);
      Map<String, Object> resolvedProps =
          surveyEngineCore.resolveItemComponentProperties(sampleProps);
      expect(resolvedProps['min'], -5);
      expect(resolvedProps['max'], 5);
      expect(resolvedProps['stepSize'], 5);
    });

    // TO DO: write a test for `exp` type once the engine rendered script is complete
  });
}

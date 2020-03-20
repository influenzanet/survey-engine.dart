import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/models/item_component/properties.dart';

class SurveyEngineCore {
  Map<String, Object> resolveItemComponentProperties(Properties props) {
    ExpressionEvaluation eval = ExpressionEvaluation();
    Map<String, Object> propertiesMap = {
      'min': eval.evaluateArgument(props.min),
      'max': eval.evaluateArgument(props.max),
      'stepSize': eval.evaluateArgument(props.stepSize)
    };
    return propertiesMap;
  }
}

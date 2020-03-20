import 'package:survey_engine.dart/src/controller/expression_eval.dart';
import 'package:survey_engine.dart/src/controller/utils.dart';
import 'package:survey_engine.dart/src/models/expression/expression.dart';
import 'package:survey_engine.dart/src/models/item_component/item_group_component.dart';
import 'package:survey_engine.dart/src/models/item_component/properties.dart';
import 'package:survey_engine.dart/src/models/localized_object/localized_object.dart';

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

  String resolveContent(List<LocalizedObject> content) {
    String resolvedContent = '';
    content.forEach((localizedObject) {
      resolvedContent =
          resolvedContent + Utils.getLocalisedString(localizedObject);
    });
    return resolvedContent;
  }

  bool displayCondition(Expression expression) {
    ExpressionEvaluation eval = ExpressionEvaluation();
    // Display condition must always be of boolean type
    if (Expression == null || expression.returnType != 'boolean') {
      return false;
    }
    return eval.evalExpression(expression: expression);
  }

  dynamic resolveItemComponentGroup(ItemGroupComponent component) {
    ExpressionEvaluation eval = ExpressionEvaluation();
    var itemGroupComponentMap = component.toMap();
    itemGroupComponentMap['displayCondition'] =
        displayCondition(component.displayCondition);
    itemGroupComponentMap['content'] = resolveContent(component.content);
    //itemGroupComponentMap['description'] = resolveContent(component.description);
    itemGroupComponentMap['disabled'] =
        eval.evalExpression(expression: component.disabled);
    itemGroupComponentMap['properties'] =
        resolveItemComponentProperties(component.properties);
  }
}

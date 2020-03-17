const List<String> expressionArgType = ['exp', 'num', 'str'];
const List<String> returnTypes = ['boolean', 'int', 'float', 'string'];
const List<Map<String, Object>> expressionArguments = [
  {'name': 'not', 'arguments': 1},
  {'name': 'or', 'arguments': 2},
  {'name': 'and', 'arguments': 2},
  {'name': 'eq', 'arguments': 2},
  {'name': 'lt', 'arguments': 2},
  {'name': 'lte', 'arguments': 2},
  {'name': 'gt', 'arguments': 2},
  {'name': 'gte', 'arguments': 2},
  {'name': 'isDefined', 'arguments': 1},
  {'name': 'regex', 'arguments': 1},
  {'name': 'getContext', 'arguments': 1},
  {'name': 'getResponses', 'arguments': 1},
  {'name': 'getRenderedItems', 'arguments': 1},
  {'name': 'getAttribute', 'arguments': 1},
  {'name': 'getArrayItemByKey', 'arguments': 1},
  {'name': 'getObjByHierarchicalKey', 'arguments': 1},
  {'name': 'getResponseItem', 'arguments': 1},
  {'name': 'getSurveyItemValidation', 'arguments': 1},
  {'name': 'sequential', 'arguments': 1},
  {'name': 'random', 'arguments': 1}
];
const int firstArgument = 0,
    secondArgument = 1,
    firstExpression = 0,
    secondExpression = 1,
    stringEqualityValue = 0,
    maxUnaryOperands = 1,
    firstComponent = 0,
    secondComponent = 1;

const List<String> displayItemComponentRoles = [
  'title',
  'text',
  'warning',
  'error'
];
const responseComponentRoles = [
  'option',
  'input',
  'multilineTextInput',
  'numberInput',
  'dateinput'
];
const List<String> responseDataType = ['string', 'number', 'date'];
const List<String> itemGroupRoles = [
  'root',
  'helpGroup',
  'responseGroup',
  'singleChoiceGroup',
  'multipleChoiceGroup',
  'dropDownGroup'
];
const List<String> validationType = ['hard', 'soft'];
const List<String> itemTypes = [
  'basic.static.title',
  'basic.static.description',
  'basic.input.numeric',
  'basic.input.single-choice',
  'basic.input.multiple-choice',
  'concepts.v1.age.simple-age'
];

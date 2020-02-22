class InvalidArgumentsException implements Exception {
  String errMsg({String message = ''}) => message + 'Not a valid argument name';
}

class ArgumentCountException implements Exception {
  String errMsg() => 'The expression has an invalid number of arguments';
}

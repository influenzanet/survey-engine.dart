class InvalidArgumentsException implements Exception {
  String errMsg() => 'Not a valid argument name';
}

class ArgumentCountException implements Exception {
  String errMsg() => 'The expression has an invalid number of arguments';
}

class InvalidArgumentsException implements Exception {
  String errMsg({String message = ''}) => message + 'Not a valid argument name';
}

class ArgumentCountException implements Exception {
  String errMsg() => 'The expression has an invalid number of arguments';
}

class InvalidRoleException {
  String message;
  InvalidRoleException({
    this.message,
  });

  @override
  String toString() => 'The role has an invalid value $message';
}

class InvalidResponseException {
  String message;
  InvalidResponseException({
    this.message,
  });

  @override
  String toString() => 'The role has an invalid value $message';
}

class InvalidValidationException {
  String message;
  InvalidValidationException({
    this.message,
  });

  @override
  String toString() => '$message';
}

class InvalidItemTypeException {
  String message;
  InvalidItemTypeException({
    this.message,
  });

  @override
  String toString() => '$message';
}

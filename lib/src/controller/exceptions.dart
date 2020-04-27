class InvalidArgumentsException implements Exception {
  String message;
  InvalidArgumentsException({
    this.message,
  });

  @override
  String toString() => 'Expected $message in arguments';
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

class InvalidContextException {
  String message;
  InvalidContextException({
    this.message,
  });

  @override
  String toString() => '$message';
}

class InvalidTimestampException {
  String message;
  InvalidTimestampException({
    this.message,
  });

  @override
  String toString() => '$message';
}

class NotFoundException {
  String object;
  NotFoundException({
    this.object,
  });

  @override
  String toString() => '$object not found';
}

class NullObjectException {
  String object;
  NullObjectException({
    this.object,
  });

  @override
  String toString() => '$object must not be null';
}

class InvalidReturnTypeException {
  String object;
  InvalidReturnTypeException({
    this.object,
  });

  @override
  String toString() => '$object is not string or number';
}

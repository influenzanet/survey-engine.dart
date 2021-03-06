class InvalidArgumentsException implements Exception {
  String message;
  InvalidArgumentsException({
    this.message,
  });

  @override
  String toString() => 'Expected $message in arguments';
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

class NullObjectException {
  String object;
  NullObjectException({
    this.object,
  });

  @override
  String toString() => '$object must not be null';
}

class MapCreationException implements Exception {
  String className;
  Map<String, dynamic> map;
  MapCreationException({this.className, this.map});

  @override
  String toString() => 'Cannot create map of $className with $map as arguments';
}

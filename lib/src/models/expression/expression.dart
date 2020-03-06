import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/models/constants.dart';

import 'expression_arg.dart';

class Expression {
  String name;
  String returnType;
  List<ExpressionArg> data;
  Expression({
    this.name,
    this.returnType,
    this.data,
  }) {
    this.returnType = this.returnType ?? 'string';
    if (!returnTypes.contains(this.returnType)) {
      throw InvalidArgumentsException(message: returnTypes.toString());
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'returnType': returnType,
      'data': List<dynamic>.from(data.map((x) => x))
    };
  }

  static Expression fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    var temp = map['data']?.map((x) => ExpressionArg.fromMap(x));
    var tempData = List<ExpressionArg>.from(temp);
    return Expression(
        name: map['name'], returnType: map['returnType'], data: tempData);
  }

  String toJson() => json.encode(toMap());

  static Expression fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Expression name: $name. Type:$returnType. Values:$data';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Expression && o.toJson() == this.toJson();
  }

  @override
  int get hashCode => name.hashCode + returnType.hashCode;
}

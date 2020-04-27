import 'dart:convert';

import 'package:survey_engine.dart/src/controller/utils.dart';

import 'expression_arg.dart';

class Expression {
  String name;
  String returnType;
  List<ExpressionArg> data;
  Expression({
    this.name,
    this.returnType,
    this.data,
  }) {}

  Map<String, dynamic> toMap() {
    return Utils.removeNullParams({
      'name': name,
      'returnType': returnType,
      'data': Utils.resolveNullListOfMaps(data)
    });
  }

  static Expression fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    var temp = map['data']?.map((x) => ExpressionArg.fromMap(x));
    var tempData = (temp == null) ? null : List<ExpressionArg>.from(temp);
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

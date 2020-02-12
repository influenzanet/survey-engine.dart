import 'dart:convert';

import 'expression_arg.dart';
import 'expression_return_type.dart';

class Expression {
  String name;
  ReturnType returnType;
  List<ExpressionArg> data;
  Expression({
    this.name,
    this.returnType,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'returnType': returnType.dType,
      'data': List<dynamic>.from(data.map((x) => x))
    };
  }

  static Expression fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    var temp = map['data']?.map((x) => ExpressionArg.fromMap(x));
    var tempData = List<ExpressionArg>.from(temp);
    return Expression(
        name: map['name'],
        returnType: ReturnType(dataType: map['returnType']),
        data: tempData);
  }

  String toJson() => json.encode(toMap());

  static Expression fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Expression name: $name. Type:$returnType. Values:$data';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Expression &&
        o.name == name &&
        o.returnType == returnType &&
        o.data == data;
  }

  @override
  int get hashCode => name.hashCode + returnType.hashCode;
}

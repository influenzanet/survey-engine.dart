import 'dart:convert';

import 'expression.dart';
import 'expression_arg_dtype.dart';

class ExpressionArg {
  ExpressionArgDType dType;
  Expression exp;
  String str;
  num number;
  ExpressionArg({
    this.dType,
    this.str,
    this.exp,
    this.number,
  });

  Map<String, dynamic> toMap() {
    return {
      'dType': dType.dType,
      'exp': exp?.toMap(),
      'str': str,
      'number': number,
    };
  }

  static ExpressionArg fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ExpressionArg(
      dType: ExpressionArgDType(dType: map['dType']),
      exp: Expression.fromMap(map['exp']),
      str: map['str'],
      number: map['number'],
    );
  }

  String toJson() => json.encode(toMap());

  static ExpressionArg fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      '\nExpressionArg exp: $exp,str: $str, number: $number, dtype:$dType';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ExpressionArg &&
        o.dType == dType &&
        o.exp == exp &&
        o.str == str &&
        o.number == number;
  }

  @override
  int get hashCode =>
      dType.hashCode + exp.hashCode + str.hashCode + number.hashCode;
}

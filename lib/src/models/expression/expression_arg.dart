import 'dart:convert';

import 'package:survey_engine.dart/src/controller/exceptions.dart';
import 'package:survey_engine.dart/src/controller/utils.dart';

import 'expression.dart';
import 'expression_arg_dtype.dart';

class ExpressionArg {
  ExpressionArgDType exprArgDType;
  Expression exp;
  String str;
  num number;
  ExpressionArg({
    this.exprArgDType,
    this.str,
    this.exp,
    this.number,
  });

  Map<String, dynamic> toMap() {
    return Utils.removeNullParams({
      'dtype': exprArgDType.dtype,
      'exp': exp?.toMap(),
      'str': str,
      'num': number,
    });
  }

  static ExpressionArg fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    try {
      return ExpressionArg(
        exprArgDType: ExpressionArgDType(dtype: map['dtype']),
        exp: Expression.fromMap(map['exp']),
        str: map['str'],
        number: map['num'],
      );
    } catch (e) {
      throw MapCreationException(className: 'ExpressionArg', map: map);
    }
  }

  String toJson() => json.encode(toMap());

  static ExpressionArg fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      '\nExpressionArg exp: $exp,str: $str, number: $number, dtype:$exprArgDType';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ExpressionArg &&
        o.exprArgDType == exprArgDType &&
        o.exp == exp &&
        o.str == str &&
        o.number == number;
  }

  @override
  int get hashCode =>
      exprArgDType.hashCode + exp.hashCode + str.hashCode + number.hashCode;
}

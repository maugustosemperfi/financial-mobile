import 'package:financial/enum/enum_account_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'account.g.dart';

@JsonSerializable(explicitToJson: true)
class Account {
  String name;
  @JsonKey(fromJson: _intToEnum, toJson: _intFromEnum)
  EnumAccountType type;
  @JsonKey(fromJson: _stringToDouble, toJson: _stringFromDouble)
  double balance;
  double realValue;

  Account(this.name, this.type, this.balance, this.realValue);

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);

  static String _stringFromDouble(double number) => number?.toString();
  static double _stringToDouble(String number) => number == null ? null : double.parse(number);

  static int _intFromEnum(EnumAccountType accountType) => accountType.index;
  static EnumAccountType _intToEnum(int accountType) =>
      EnumAccountType.values[accountType];
}

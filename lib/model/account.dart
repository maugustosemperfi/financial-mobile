import 'package:financial/enum/enum_account_type.dart';
import 'package:financial/model/bank.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable(explicitToJson: true)
class Account {
  int id;
  String name;
  @JsonKey(fromJson: _intToEnum, toJson: _intFromEnum, nullable: true)
  EnumAccountType type;
  @JsonKey(fromJson: _stringToDouble, toJson: _stringFromDouble)
  double balance;
  @JsonKey(nullable: true)
  double realValue;
  String descritpion;
  Bank bank;

  Account(this.name, this.type, this.balance, this.realValue);

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);

  static String _stringFromDouble(double number) => number?.toString();
  static double _stringToDouble(String number) =>
      number == null ? null : double.parse(number);

  static int _intFromEnum(EnumAccountType accountType) => accountType.index;
  static EnumAccountType _intToEnum(int accountType) =>
      accountType != null ? EnumAccountType.values[accountType] : null;
}

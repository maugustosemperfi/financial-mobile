import 'package:financial/model/account.dart';
import 'package:json_annotation/json_annotation.dart';

part 'overview_account.g.dart';

@JsonSerializable(explicitToJson: true)
class OverviewAccount {
  double overallBalance;
  List<Account> accounts;

  OverviewAccount(this.overallBalance, this.accounts);

  factory OverviewAccount.fromJson(Map<String, dynamic> json) =>
      _$OverviewAccountFromJson(json);
  Map<String, dynamic> toJson() => _$OverviewAccountToJson(this);

  static String _stringFromDouble(double number) => number?.toString();
  static double _stringToDouble(String number) =>
      number == null ? null : double.parse(number);
}

import 'package:json_annotation/json_annotation.dart';

part 'bank.g.dart';

@JsonSerializable(explicitToJson: true)
class Bank {
  int id;
  String name;
  String description;
  String iconName;
  String iconUrl;

  Bank({this.id, this.name, this.description, this.iconName, this.iconUrl});

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);
  Map<String, dynamic> toJson() => _$BankToJson(this);
}

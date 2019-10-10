import 'package:financial/model/account.dart';
import 'package:financial/model/bank.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credit_card.g.dart';

@JsonSerializable(explicitToJson: true)
class CreditCard {
  int id;
  String name;
  double limit;
  int cycleDay;
  int dueDay;
  @JsonKey(nullable: true)
  double statement;
  @JsonKey(nullable: true)
  Bank bank;
  @JsonKey(nullable: true)
  Account account;

  CreditCard({this.id, this.name, this.cycleDay, this.dueDay});

  factory CreditCard.fromJson(Map<String, dynamic> json) =>
      _$CreditCardFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'credit_card.g.dart';

@JsonSerializable(explicitToJson: true)
class CreditCard {
  int id;
  String name;
  int cycleDay;
  int dueDay;

  CreditCard({this.id, this.name, this.cycleDay, this.dueDay});

  factory CreditCard.fromJson(Map<String, dynamic> json) =>
      _$CreditCardFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardToJson(this);
}

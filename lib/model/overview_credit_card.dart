import 'package:financial/model/credit_card.dart';
import 'package:json_annotation/json_annotation.dart';

part 'overview_credit_card.g.dart';

@JsonSerializable(explicitToJson: true)
class OverviewCreditCard {
  double overallStatement;
  List<CreditCard> creditCards;

  OverviewCreditCard({this.overallStatement, this.creditCards});

  factory OverviewCreditCard.fromJson(Map<String, dynamic> json) =>
      _$OverviewCreditCardFromJson(json);
  Map<String, dynamic> toJson() => _$OverviewCreditCardToJson(this);
}

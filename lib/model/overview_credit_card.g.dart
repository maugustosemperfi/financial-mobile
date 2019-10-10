// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_credit_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverviewCreditCard _$OverviewCreditCardFromJson(Map<String, dynamic> json) {
  return OverviewCreditCard(
    overallStatement: (json['overallStatement'] as num)?.toDouble(),
    creditCards: (json['creditCards'] as List)
        ?.map((e) =>
            e == null ? null : CreditCard.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OverviewCreditCardToJson(OverviewCreditCard instance) =>
    <String, dynamic>{
      'overallStatement': instance.overallStatement,
      'creditCards': instance.creditCards?.map((e) => e?.toJson())?.toList(),
    };

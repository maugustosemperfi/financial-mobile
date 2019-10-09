// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCard _$CreditCardFromJson(Map<String, dynamic> json) {
  return CreditCard(
    id: json['id'] as int,
    name: json['name'] as String,
    cycleDay: json['cycleDay'] as int,
    dueDay: json['dueDay'] as int,
  );
}

Map<String, dynamic> _$CreditCardToJson(CreditCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cycleDay': instance.cycleDay,
      'dueDay': instance.dueDay,
    };

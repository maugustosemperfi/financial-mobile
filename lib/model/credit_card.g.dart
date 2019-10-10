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
  )
    ..limit = (json['limit'] as num)?.toDouble()
    ..statement = (json['statement'] as num)?.toDouble()
    ..bank = json['bank'] == null
        ? null
        : Bank.fromJson(json['bank'] as Map<String, dynamic>)
    ..account = json['account'] == null
        ? null
        : Account.fromJson(json['account'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreditCardToJson(CreditCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'limit': instance.limit,
      'cycleDay': instance.cycleDay,
      'dueDay': instance.dueDay,
      'statement': instance.statement,
      'bank': instance.bank?.toJson(),
      'account': instance.account?.toJson(),
    };

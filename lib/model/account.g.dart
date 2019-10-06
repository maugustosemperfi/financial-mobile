// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    json['name'] as String,
    Account._intToEnum(json['type'] as int),
    Account._stringToDouble(json['balance'] as String),
    (json['realValue'] as num)?.toDouble(),
  )
    ..id = json['id'] as int
    ..descritpion = json['descritpion'] as String
    ..bank = json['bank'] == null
        ? null
        : Bank.fromJson(json['bank'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': Account._intFromEnum(instance.type),
      'balance': Account._stringFromDouble(instance.balance),
      'realValue': instance.realValue,
      'descritpion': instance.descritpion,
      'bank': instance.bank?.toJson(),
    };

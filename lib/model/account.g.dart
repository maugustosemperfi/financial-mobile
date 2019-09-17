// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    json['name'] as String,
    Account._intToEnum(json['type'] as int),
  )..balance = Account._stringToDouble(json['balance'] as String);
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'name': instance.name,
      'type': Account._intFromEnum(instance.type),
      'balance': Account._stringFromDouble(instance.balance),
    };

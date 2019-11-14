// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Record _$RecordFromJson(Map<String, dynamic> json) {
  return Record(
    id: json['id'] as int,
    description: json['description'] as String,
    value: (json['value'] as num)?.toDouble(),
    type: Record._intToEnum(json['type'] as int),
    account: json['account'] == null
        ? null
        : Account.fromJson(json['account'] as Map<String, dynamic>),
    recordDate: json['recordDate'] == null
        ? null
        : DateTime.parse(json['recordDate'] as String),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    creditCard: json['creditCard'] == null
        ? null
        : CreditCard.fromJson(json['creditCard'] as Map<String, dynamic>),
  )..recordDay = json['recordDay'] == null
      ? null
      : DateTime.parse(json['recordDay'] as String);
}

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'value': instance.value,
      'type': Record._intFromEnum(instance.type),
      'account': instance.account?.toJson(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'recordDate': instance.recordDate?.toIso8601String(),
      'recordDay': instance.recordDay?.toIso8601String(),
      'creditCard': instance.creditCard?.toJson(),
    };

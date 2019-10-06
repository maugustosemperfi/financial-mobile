// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) {
  return Bank(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    iconName: json['iconName'] as String,
    iconUrl: json['iconUrl'] as String,
  );
}

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'iconName': instance.iconName,
      'iconUrl': instance.iconUrl,
    };

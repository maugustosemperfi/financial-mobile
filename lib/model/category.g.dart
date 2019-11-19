// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    id: json['id'] as int,
    description: json['description'] as String,
    iconName: json['iconName'] as String,
    iconColor: json['iconColor'] as String,
    type: Category._intToEnum(json['type'] as int),
  )..defaultCategory = json['defaultCategory'] as bool;
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'iconName': instance.iconName,
      'iconColor': instance.iconColor,
      'type': Category._intFromEnum(instance.type),
      'defaultCategory': instance.defaultCategory,
    };

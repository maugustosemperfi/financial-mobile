// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    json['id'] as int,
    json['description'] as String,
    json['iconName'] as String,
    json['iconColor'] as String,
    Category._intToEnum(json['type'] as int),
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'iconName': instance.iconName,
      'iconColor': instance.iconColor,
      'type': Category._intFromEnum(instance.type),
    };

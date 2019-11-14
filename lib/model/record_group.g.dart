// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordGroup _$RecordGroupFromJson(Map<String, dynamic> json) {
  return RecordGroup(
    recordDay: json['recordDay'] == null
        ? null
        : DateTime.parse(json['recordDay'] as String),
    records: (json['records'] as List)
        ?.map((e) =>
            e == null ? null : Record.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RecordGroupToJson(RecordGroup instance) =>
    <String, dynamic>{
      'recordDay': instance.recordDay?.toIso8601String(),
      'records': instance.records?.map((e) => e?.toJson())?.toList(),
    };

import 'package:financial/enum/enum_record_type.dart';
import 'package:financial/model/account.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record.g.dart';

@JsonSerializable(explicitToJson: true)
class Record {
  int id;
  String description;
  double value;
  @JsonKey(fromJson: _intToEnum, toJson: _intFromEnum)
  EnumRecordType type;
  Account account;
  DateTime createdAt;
  DateTime recordDate;

  Record(
      {this.id,
      this.description,
      this.value,
      this.type,
      this.account,
      this.recordDate,
      this.createdAt});

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
  Map<String, dynamic> toJson() => _$RecordToJson(this);

  static int _intFromEnum(EnumRecordType accountType) => accountType.index;
  static EnumRecordType _intToEnum(int accountType) =>
      EnumRecordType.values[accountType];
}

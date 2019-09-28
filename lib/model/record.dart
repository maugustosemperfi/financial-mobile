import 'package:financial/model/account.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record.g.dart';

@JsonSerializable(explicitToJson: true)
class Record {
  int id;
  String description;
  double value;
  double type;
  Account account;
  DateTime createdAt;

  Record({this.id, this.description, this.value, this.type});

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
  Map<String, dynamic> toJson() => _$RecordToJson(this);
}

import 'package:financial/model/record.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record_group.g.dart';

@JsonSerializable(explicitToJson: true)
class RecordGroup {
  DateTime recordDay;
  List<Record> records;

  RecordGroup({this.recordDay, this.records});

  factory RecordGroup.fromJson(Map<String, dynamic> json) =>
      _$RecordGroupFromJson(json);
  Map<String, dynamic> toJson() => _$RecordGroupToJson(this);
}

import 'package:financial/enum/enum_record_type.dart';
import 'package:financial/model/account.dart';
import 'package:financial/model/category.dart';
import 'package:financial/model/credit_card.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record.g.dart';

@JsonSerializable(explicitToJson: true)
class Record {
  int id;
  String description;
  double value;
  @JsonKey(fromJson: _intToEnum, toJson: _intFromEnum)
  EnumRecordType type;
  @JsonKey(nullable: true)
  Account account;
  DateTime createdAt;
  DateTime recordDate;
  DateTime recordDay;
  @JsonKey(nullable: true)
  CreditCard creditCard;
  Category category;

  Record(
      {this.id,
      this.description,
      this.value,
      this.type,
      this.account,
      this.recordDate,
      this.createdAt,
      this.creditCard,
      this.category});

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
  Map<String, dynamic> toJson() => _$RecordToJson(this);

  static int _intFromEnum(EnumRecordType accountType) => accountType.index;
  static EnumRecordType _intToEnum(int accountType) =>
      EnumRecordType.values[accountType];
}

import 'package:financial/enum/enum_record_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  int id;
  String description;
  String iconName;
  String iconColor;
  @JsonKey(fromJson: _intToEnum, toJson: _intFromEnum)
  EnumRecordType type;

  Category(
      this.id, this.description, this.iconName, this.iconColor, this.type);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  static int _intFromEnum(EnumRecordType accountType) => accountType.index;
  static EnumRecordType _intToEnum(int accountType) =>
      EnumRecordType.values[accountType];
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverviewAccount _$OverviewAccountFromJson(Map<String, dynamic> json) {
  return OverviewAccount(
    (json['overallBalance'] as num)?.toDouble(),
    (json['accounts'] as List)
        ?.map((e) =>
            e == null ? null : Account.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OverviewAccountToJson(OverviewAccount instance) =>
    <String, dynamic>{
      'overallBalance': instance.overallBalance,
      'accounts': instance.accounts?.map((e) => e?.toJson())?.toList(),
    };

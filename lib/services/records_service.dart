import 'dart:convert';

import 'package:financial/application.dart';
import 'package:financial/model/record.dart';

class RecordsService {
  static createRecord(Record record) async {
    return await Application.dio.post('records', data: record);
  }

  static Future<List<Record>> getTransactionsRecords(DateTime dateTime) async {
    final recordsJson = await Application.dio.get('records/transactions',
        queryParameters: {"date": dateTime.toIso8601String()});

    return (jsonDecode(recordsJson.data) as List)
        .map((record) => Record.fromJson(record))
        .toList();
  }
}

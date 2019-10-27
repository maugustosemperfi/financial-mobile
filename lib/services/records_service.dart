import 'package:financial/application.dart';
import 'package:financial/model/record.dart';

class RecordsService {
  static createRecord(Record record) async {
    return await Application.dio.post('records', data: record);
  }

  static getTransactionsRecords(DateTime dateTime) async {
    return await Application.dio.get('records/transactions',
        queryParameters: {"date": dateTime.toIso8601String()});
  }
}

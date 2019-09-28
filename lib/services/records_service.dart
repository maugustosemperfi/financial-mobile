import 'package:financial/application.dart';
import 'package:financial/model/record.dart';

class RecordsService {
  static createRecord(Record record) async {
    return await Application.dio.post('records', data: record);
  }
}

import 'package:financial/application.dart';

class BankService {
  static getAll() async {
    return await Application.dio.get('banks');
  }
}

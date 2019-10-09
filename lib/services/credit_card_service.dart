import 'package:financial/application.dart';

class CreditCardService {
  static getAll() async {
    return Application.dio.get('credit-cards');
  }
}

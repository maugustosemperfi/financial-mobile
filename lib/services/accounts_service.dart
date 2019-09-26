import 'package:financial/application.dart';

class AccountsService {
  static getOverview() {
    return Application.dio.get('accounts/overview');
  }
}

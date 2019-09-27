import 'package:financial/application.dart';

class AccountsService {
  static getOverview() async {
    return await Application.dio.get('accounts/overview');
  }

  static getSimpleAccounts() async {
    return await Application.dio.get('accounts/simple');
  }
}

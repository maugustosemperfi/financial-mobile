import 'dart:convert';

import 'package:financial/application.dart';
import 'package:financial/model/overview_account.dart';

class AccountsService {
  static Future<OverviewAccount> getOverview() async {
    var accountsData = await Application.dio.get('accounts/overview');
    return OverviewAccount.fromJson(jsonDecode(accountsData.data));
  }

  static getSimpleAccounts() async {
    return await Application.dio.get('accounts/simple');
  }
}

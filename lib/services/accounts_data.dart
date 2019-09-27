import 'dart:convert';

import 'package:financial/model/account.dart';
import 'package:flutter/material.dart';

class AccountsData {
  static List<Account> simpleAccounts = [];

  static setSimpleAccounts(simpleAccountsJson) {
    if (simpleAccountsJson != null) {
      AccountsData.simpleAccounts = (jsonDecode(simpleAccountsJson) as List)
          .map((account) => Account.fromJson(account))
          .toList();
    }
  }
}

import 'package:flutter/material.dart';

enum EnumAccountType { checking, saving, others }

class AccountType {
  static getIconByAccountType(type) {
    switch (type) {
      case EnumAccountType.checking:
        return Icons.account_balance;

      case EnumAccountType.saving:
        return Icons.multiline_chart;

      case EnumAccountType.others:
        return Icons.account_balance_wallet;

      default:
        return Icons.account_balance;
    }
  }

  static getAccountNameByAccountType(type) {
    switch (type) {
      case EnumAccountType.checking:
        return "Checking account";

      case EnumAccountType.saving:
        return "Savings or investmentst";

      case EnumAccountType.others:
        return "Others";

      default:
        return "Checking account";
    }
  }
}

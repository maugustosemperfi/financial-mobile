import 'package:flutter/material.dart';

enum EnumAccountType { checking, saving, others }

class AccountType {
  static getIconByAccountType(type) {
    switch (type) {
      case EnumAccountType.checking:
        return Icons.account_balance;

      case EnumAccountType.saving:
        return Icons.account_balance;

      case EnumAccountType.others:
        return Icons.account_balance_wallet;

      default:
        return Icons.account_balance;
    }
  }
}

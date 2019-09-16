import 'package:flutter/material.dart';

enum EnumAccountType { checking }

class AccountType {
  static getIconByAccountType(type) {
    switch (type) {
      case EnumAccountType.checking:
        return Icons.account_balance;

      default:
        return Icons.account_balance;
    }
  }
}

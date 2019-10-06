import 'dart:convert';

import 'package:financial/model/bank.dart';

class BanksData {
  static List<Bank> banks = [];

  static setSimpleBanks(banksJson) {
    if (banksJson != null) {
      BanksData.banks = (jsonDecode(banksJson) as List)
          .map((account) => Bank.fromJson(account))
          .toList();
    }
  }
}

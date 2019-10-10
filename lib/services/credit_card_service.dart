import 'dart:convert';

import 'package:financial/application.dart';
import 'package:financial/model/credit_card.dart';
import 'package:financial/model/overview_credit_card.dart';

class CreditCardService {
  static Future<OverviewCreditCard> overview() async {
    final overviewCreditCardsJson =
        await Application.dio.get('credit-cards/overview');

    final overviewCreditCards =
        OverviewCreditCard.fromJson(jsonDecode(overviewCreditCardsJson.data));

    return overviewCreditCards;
  }

  static Future<List<CreditCard>> getAll() async {
    final creditCardsJson = await Application.dio.get('credit-cards');

    return (jsonDecode(creditCardsJson.data) as List)
        .map((creditCard) => CreditCard.fromJson(creditCard))
        .toList();
  }
}

import 'dart:convert';

import 'package:financial/model/credit_card.dart';

class CreditCardData {
  static List<CreditCard> simpleCreditCards = [];

  static setSimpleCreditCards(simpleCreditCardsJson) {
    if (simpleCreditCardsJson != null) {
      CreditCardData.simpleCreditCards = (jsonDecode(simpleCreditCardsJson) as List)
          .map((creditCard) => CreditCard.fromJson(creditCard))
          .toList();
    }
  }
}

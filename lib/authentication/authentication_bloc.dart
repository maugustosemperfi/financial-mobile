import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:financial/application.dart';
import 'package:financial/authentication/authentication_event.dart';
import 'package:financial/authentication/authentication_state.dart';
import 'package:financial/model/category.dart';
import 'package:financial/model/category.dart' as mycategory;
import 'package:financial/services/accounts_data.dart';
import 'package:financial/services/accounts_service.dart';
import 'package:financial/services/banks.service.dart';
import 'package:financial/services/banks_data.dart';
import 'package:financial/services/categories_service.dart';
import 'package:financial/services/credit_card_data.dart';
import 'package:financial/services/credit_card_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  FlutterSecureStorage storage;

  AuthenticationBloc() {
    storage = new FlutterSecureStorage();
  }

  @override
  AuthenticationState get initialState => AuthenticationUnitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await storage.read(key: "token") != null;

      if (hasToken) {
        final simpleAccountsJson =
            await storage.read(key: "accounts:simple-accounts");
        final banksJson = await storage.read(key: "banks:all-banks");
        final simpleCreditCardsJson =
            await storage.read(key: "credit-cards:simple-credit-cards");
        AccountsData.setSimpleAccounts(simpleAccountsJson);
        BanksData.setSimpleBanks(banksJson);
        CreditCardData.setSimpleCreditCards(simpleCreditCardsJson);

        yield AuthenticationAuthenticated(categories: await getCategories());
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await storage.write(key: "token", value: event.token);
      Application.authenticationToken = event.token;
      final simpleAccountsJson = await AccountsService.getSimpleAccounts();
      final banksJson = await BankService.getAll();
      final creditCardsJson =
          await CreditCardService.getSimpleCreditCards(convertToJson: false);
      await storage.write(
          key: "accounts:simple-accounts", value: simpleAccountsJson.data);
      await storage.write(key: "banks:all-banks", value: banksJson.data);
      await storage.write(
          key: "credit-cards:simple-credit-cards", value: creditCardsJson);
      setStorageCategories();
      AccountsData.setSimpleAccounts(simpleAccountsJson.data);
      BanksData.setSimpleBanks(banksJson.data);
      CreditCardData.setSimpleCreditCards(creditCardsJson);
      yield AuthenticationAuthenticated(categories: await getCategories());
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await storage.delete(key: "token");
      yield AuthenticationUnauthenticated();
    }
  }

  setStorageCategories() async {
    final categoriesJson = await CategoriesService.getCategoriesJson();

    await storage.write(
        key: "categories:all-categories", value: categoriesJson);
  }

  Future<List<Category>> getCategories() async {
    final categoriesJson = await storage.read(key: "categories:all-categories");

    if (categoriesJson != null) {
      final List<Category> categories = (jsonDecode(categoriesJson) as List)
          .map((category) => Category.fromJson(category))
          .toList();

      return categories;
    }

    return null;
  }
}

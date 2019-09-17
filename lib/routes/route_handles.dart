import 'package:financial/enum/enum_account_type.dart';
import 'package:financial/pages/add_account/add_account_page.dart';
import 'package:financial/pages/home/home_page.dart';
import 'package:financial/pages/login/login_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

var homePageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

var addAccountPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AddAccountPage(
    type: params["type"][0] as EnumAccountType,
  );
});

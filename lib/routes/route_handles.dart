import 'package:financial/create_record_page.dart';
import 'package:financial/enum/enum_account_type.dart';
import 'package:financial/enum/enum_record_type.dart';
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
    type: EnumAccountType.values[int.parse(params["type"][0])],
  );
});

var createRecordPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CreateRecordPage(
      balance: double.parse(params["balance"][0]),
      recordType: EnumRecordType.values[int.parse(params["type"][0])]);
});

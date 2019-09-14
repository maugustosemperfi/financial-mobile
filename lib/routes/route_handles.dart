import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:financial/pages/home/home_page.dart';
import 'package:financial/pages/login/login_page.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

var homePageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage();
});

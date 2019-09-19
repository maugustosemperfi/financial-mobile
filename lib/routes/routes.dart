import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:financial/routes/route_handles.dart';

class Routes {
  static String root = "/";
  static String homePage = "/home";
  static String addAccountPage = "/account/add/:type";
  static String createRecordPage = "/record/add/:balance";

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
    router.define(homePage, handler: homePageHandler);
    router.define(addAccountPage, handler: addAccountPageHandler);
    router.define(createRecordPage, handler: createRecordPageHandler);
  }
}

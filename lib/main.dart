import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reply/home_page.dart';
import 'package:reply/model/email_model.dart';
import 'package:reply/pages/login/login_page.dart';
import 'package:reply/styling.dart';
import 'http.dart';



_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void main() {
  // (CustomDio.dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

  runApp(ReplyApp());
}

class ReplyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EmailModel>.value(value: EmailModel()),
      ],
      child: MaterialApp(
        title: 'Reply',
        theme: ThemeData(
          scaffoldBackgroundColor: AppTheme.notWhite,
          canvasColor: AppTheme.notWhite,
          accentColor: AppTheme.green,
          textTheme: AppTheme.textTheme,
        ),
        onGenerateRoute: (RouteSettings settings) {
          print(settings.isInitialRoute);
          if (settings.isInitialRoute) {
            return PageRouteBuilder<void>(
                pageBuilder: (BuildContext context, _, __) => LoginPage());
          }
        },
      ),
    );
  }
}

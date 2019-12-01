import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:financial/pages/login/login.dart';
import 'package:financial/pages/transactions/state/transactions_bloc.dart';
import 'package:financial/splash_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:financial/application.dart';
import 'package:financial/authentication/authentication.dart';
import 'package:financial/model/email_model.dart';
import 'package:financial/routes/routes.dart';
import 'package:financial/styling.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

addDioInterceptors(Dio dio) async {}

void main() async {
  // (CustomDio.dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  BlocSupervisor.delegate = SimpleBlocDelegate();
  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  final token = await flutterSecureStorage.read(key: "token");
  Application.authenticationToken = token;

  final dio = Dio(BaseOptions(
    baseUrl: "http://192.168.0.59:3000/",
    connectTimeout: 5000,
    receiveTimeout: 100000,
    headers: {
      HttpHeaders.userAgentHeader: "dio",
      "api": "1.0.0",
    },
    contentType: ContentType.json,
    // Transform the response data to a String encoded with UTF8.
    // The default value is [ResponseType.JSON].
    responseType: ResponseType.plain,
  ));

  dio
    ..interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      final token = Application.authenticationToken;

      if (token != null) {
        options.headers.addAll({"Authorization": "Bearer $token"});
      }

      return options;
    }));

  Application.dio = dio;

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc()..add(AppStarted());
        },
      ),
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
      ),
      BlocProvider<TransactionsBloc>(
        create: (context) => TransactionsBloc(),
      )
    ],
    child: FinancialApp(),
  ));
}

class FinancialApp extends StatefulWidget {
  @override
  _FinancialAppState createState() => _FinancialAppState();
}

class _FinancialAppState extends State<FinancialApp> {
  _FinancialAppState() {
    final router = Router();

    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EmailModel>.value(value: EmailModel()),
      ],
      child: MaterialApp(
        title: 'Financial',
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: AppTheme.notWhite,
          canvasColor: AppTheme.notWhite,
          accentColor: AppTheme.colorStrong,
          primaryColor: AppTheme.colorStrong,
          textTheme: AppTheme.textTheme,
        ),
        home: SplashPage(),
        // onGenerateRoute: Application.router.generator,
      ),
    );
  }
}

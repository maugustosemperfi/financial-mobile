import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:financial/application.dart';
import 'package:financial/authentication/authentication.dart';
import 'package:financial/model/email_model.dart';
import 'package:financial/pages/home/home_page.dart';
import 'package:financial/pages/login/login_page.dart';
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
    baseUrl: "http://192.168.0.55:3000/",
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
        options.headers.addAll({
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNTY4NTQ4OTA2LCJleHAiOjE1NjkxNTM3MDZ9.YS6vttuxm3vheA0i2S6688iErgl0wjyqg94Gc-iVsT0"
        });
      }

      return options;
    }));

  Application.dio = dio;

  runApp(BlocProvider<AuthenticationBloc>(
    builder: (context) {
      return AuthenticationBloc()..dispatch(AppStarted());
    },
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
        title: 'Reply',
        theme: ThemeData(
          scaffoldBackgroundColor: AppTheme.notWhite,
          canvasColor: AppTheme.notWhite,
          accentColor: AppTheme.green,
          textTheme: AppTheme.textTheme,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUnitialized ||
                state is AuthenticationUnauthenticated) {
              return LoginPage();
            }

            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }
          },
        ),
        // onGenerateRoute: Application.router.generator,
      ),
    );
  }
}

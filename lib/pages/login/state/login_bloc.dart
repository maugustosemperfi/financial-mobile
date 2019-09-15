import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:financial/authentication/authentication_bloc.dart';
import 'package:financial/authentication/authentication_event.dart';
import 'package:financial/http.dart';
import 'package:financial/pages/login/state/login_event.dart';
import 'package:financial/pages/login/state/login_state.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.authenticationBloc}) {
    assert(authenticationBloc != null);
  }

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final Response token = await CustomDio.dio.post(
          "http://192.168.0.55:3000/login",
          data: {"email": event.email, "password": event.password},
        );

        Map<String, dynamic> jsonToken = jsonDecode(token.data);
        authenticationBloc.dispatch(LoggedIn(token: jsonToken['token']));

        yield LoginInitial();
      } on DioError catch (error) {
        yield LoginFailure(error: error.response.data);
      }
    }
    // TODO: implement mapEventToState
  }
}

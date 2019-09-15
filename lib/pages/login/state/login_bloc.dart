import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:financial/application.dart';
import 'package:financial/authentication/authentication_bloc.dart';
import 'package:financial/authentication/authentication_event.dart';
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
        final Response token = await Application.dio.post(
          "login",
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

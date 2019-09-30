import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:financial/model/user.dart';
import 'package:financial/pages/login/login.dart';
import 'package:financial/pages/sign_up/state/sign_up.dart';
import 'package:financial/services/user_service.dart';
import 'package:meta/meta.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final LoginBloc loginBloc;

  SignUpBloc({@required this.loginBloc}) {
    assert(loginBloc != null);
  }

  @override
  SignUpState get initialState => SignUpInitial();

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUpButtonPressed) {
      yield SignUpLoading();

      try {
        final Response createdUserJsonData =
            await UserService.createUser(event.user);

        User createdUser = User.fromJson(jsonDecode(createdUserJsonData.data));

        loginBloc.dispatch(LoginButtonPressed(
            email: event.user.email, password: event.user.password));

        yield SignUpSuccess();
      } catch (err) {
        yield SignUpFail();
      }
    }
  }
}

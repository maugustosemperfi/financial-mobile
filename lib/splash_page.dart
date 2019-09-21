import 'package:financial/application.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:financial/authentication/authentication.dart';

class SplashPage extends StatelessWidget {
  AuthenticationBloc _authenticationBloc;

  @override
  Widget build(BuildContext context) {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationUnauthenticated) {
          Application.router.navigateTo(context, '/',
              transition: TransitionType.cupertino, replace: true);
        }

        if (state is AuthenticationAuthenticated) {
          Application.router.navigateTo(context, '/home',
              transition: TransitionType.cupertino, replace: true);
        }
      },
      child: Container(
        child: Center(
          child: Text("Loading"),
        ),
      ),
    );
  }
}

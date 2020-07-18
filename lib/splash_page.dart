import 'package:financial/application.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  navigate(context) {
    Application.router.navigateTo(context, '/',
        transition: TransitionType.cupertino, replace: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: navigate(context),
          child: Text("Clica ai"),
        ),
      ),
    );
  }
}

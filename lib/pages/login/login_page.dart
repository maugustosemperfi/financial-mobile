import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:financial/authentication/authentication.dart';
import 'package:financial/pages/login/login.dart';
import 'package:financial/pages/login/state/login_bloc.dart';
import 'package:financial/pages/login/widgets/login_form.dart';
import 'package:financial/styling.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: BlocProvider(
        builder: (context) {
          return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 48),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(bottom: 24),
                                  child: Image.asset(
                                      'assets/images/financial_green.png', height: 64,),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 12),
                                  child: Text(
                                    "Welcome to Dixty",
                                    style: AppTheme.headline,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 24),
                                  child: Text(
                                    "Save your fundings in the right way",
                                    style: AppTheme.title,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 48),
                              child: Column(
                                children: <Widget>[
                                  LoginWidgetForm(),
                                  _signUp()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider(int height) {
    return Divider(
      color: Colors.transparent,
      height: height.toDouble(),
    );
  }

  Widget _signUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don't have an account?",
          style: AppTheme.caption,
        ),
        RichText(
          text: TextSpan(
              text: "Sign up",
              style: AppTheme.captionBold,
              recognizer: TapGestureRecognizer()..onTap = () {}),
        )
      ],
    );
  }
}

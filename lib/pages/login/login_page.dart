import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reply/http.dart';
import 'package:http/http.dart' as http;

import 'package:reply/styling.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;

  _login() async {
    final user = await CustomDio.dio.post(
      "http://192.168.0.56:3000/login",
      queryParameters: {"email": "augustoprofemp@gmail.com"},
      data: {
        "email": "augustoprofemp@gmail.com",
        "password": "123456"
      },
    );

    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Card(
                      elevation: 6,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: Text(
                                "Sign in",
                                style: AppTheme.headline,
                              ),
                            ),
                            _loginForm(),
                            _divider(8),
                            _forgotPassword(),
                            _divider(24),
                            _loginButton(),
                            _divider(24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "OR",
                                  style: AppTheme.subtitleLight,
                                ),
                              ],
                            ),
                            _divider(24),
                            _signInGoogle(),
                            _divider(24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            _signUp(),
            _divider(24)
          ],
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

  Widget _loginForm() {
    return Column(children: <Widget>[
      TextFormField(
        decoration: InputDecoration(
          hintText: 'Enter your email',
          labelText: 'Email',
          prefixIcon: Icon(
            Icons.email,
            size: 16,
          ),
          border: OutlineInputBorder(),
        ),
      ),
      _divider(32),
      TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Enter your password',
          labelText: 'Password',
          prefixIcon: Icon(
            Icons.build,
            size: 16,
          ),
          border: OutlineInputBorder(),
        ),
      )
    ]);
  }

  Widget _forgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        RichText(
          text: TextSpan(
              text: "Forgot Password?",
              style: AppTheme.caption,
              recognizer: TapGestureRecognizer()..onTap = () {}),
        )
      ],
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

  Widget _loginButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: ButtonTheme(
            padding: EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RaisedButton(
              onPressed: () => _login(),
              color: AppTheme.green,
              textColor: Colors.white,
              child: Text(
                "LOGIN",
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _signInGoogle() {
    return Row(
      children: <Widget>[
        Expanded(
          child: ButtonTheme(
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.black)),
            child: RaisedButton(
                onPressed: () {},
                color: AppTheme.nearlyWhite,
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Container(
                  height: 36,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            Positioned(
                              top: 10,
                              child: Text(
                                "Sign in with google",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Positioned(
                              right: 16,
                              child: Image.asset('assets/images/ic_google.png'),
                              height: 24,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reply/styling.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                            Divider(
                              color: Colors.transparent,
                              height: 32,
                            ),
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
                            ),
                            Divider(
                              color: Colors.transparent,
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                      text: "Forgot Password?",
                                      style: AppTheme.caption,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {}),
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.transparent,
                              height: 24,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: ButtonTheme(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: RaisedButton(
                                      onPressed: () {},
                                      color: AppTheme.green,
                                      textColor: Colors.white,
                                      child: Text(
                                        "LOGIN",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.transparent,
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "OR",
                                  style: AppTheme.subtitleLight,
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.transparent,
                              height: 24,
                            ),
                            Row(
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
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Stack(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              children: <Widget>[
                                                Positioned(
                                                  child: Text(
                                                    "Sign in with google",
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 16,
                                                  child: Icon(Icons.camera_alt),
                                                )
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
                            Divider(color: Colors.transparent, height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

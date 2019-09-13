import 'package:fluro/fluro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reply/application.dart';
import 'package:reply/http.dart';
import 'package:reply/pages/home/home_page.dart';
import 'package:reply/routes/routes.dart';
import 'package:reply/styling.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;
  bool loging = false;
  Widget _animatedWiget;

  @override
  void initState() {
    super.initState();

    _animatedWiget = _textSignInButton();
  }

  _login() async {
    this.loging = true;
    this.switchAnimatedWidget();

    // final user = await CustomDio.dio.post(
    //   "http://192.168.0.56:3000/login",
    //   data: {"email": "augustoprofemp@gmail.com", "password": "123456"},
    // );

    await Future.delayed(Duration(seconds: 2));

    this.loging = false;
    this.switchAnimatedWidget();
    // Application.router.navigateTo(context, 'home', transition: TransitionType.native, transitionDuration: Duration(seconds: 10));
    Navigator.pushReplacementNamed(context, '/home');
  }

  void switchAnimatedWidget() {
    setState(() {
      if (_animatedWiget.key == ValueKey(1)) {
        _animatedWiget = _circularProgressSignInButton();
      } else {
        _animatedWiget = _textSignInButton();
      }
    });
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
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
                            _signInButton(),
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

  Widget _signInButton() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: _animatedWiget,
    );
  }

  Widget _textSignInButton() {
    return Row(
      key: ValueKey(1),
      children: <Widget>[
        Expanded(
          child: ButtonTheme(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RaisedButton(
              onPressed: () {
                if (!loging) {
                  _login();
                }
              },
              color: AppTheme.green,
              textColor: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text("Login"),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _circularProgressSignInButton() {
    return Container(
      key: ValueKey(2),
      child: ButtonTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: RaisedButton(
          onPressed: () {},
          color: AppTheme.green,
          textColor: Colors.white,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
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

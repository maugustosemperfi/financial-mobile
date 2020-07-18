import 'package:financial/styling.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _autovalidate = false;
  bool _signing = false;
  Widget _animatedWiget;

  final loginForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _animatedWiget = _textSignUpButton();
  }

  void switchAnimatedWidget() {
    setState(() {
      if (_animatedWiget.key == ValueKey(1)) {
        _animatedWiget = _circularProgressSignInButton();
      } else {
        _animatedWiget = _textSignUpButton();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.nearlyWhite,
        elevation: 0,
      ),
      backgroundColor: AppTheme.nearlyWhite,
      resizeToAvoidBottomPadding: false,
      body: Container(
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
                                  'assets/images/financial_green.png',
                                  height: 64,
                                ),
                              ),
                              Form(
                                key: loginForm,
                                autovalidate: _autovalidate,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (String email) {
                                        if (!RegExp(
                                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                            .hasMatch(email)) {
                                          return "Email is not valid";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Enter your email',
                                        labelText: 'Email',
                                      ),
                                    ),
                                    _divider(32),
                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      validator: (String pass) {
                                        if (pass.length < 8) {
                                          return "Password should have 8 characters";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Enter your password',
                                        labelText: 'Password',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _signUpButton(),
                            ],
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
    );
  }

  Widget _signUpButton() {
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

  Widget _textSignUpButton() {
    return Row(
      key: ValueKey(1),
      children: <Widget>[
        Expanded(
          child: ButtonTheme(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: RaisedButton(
              onPressed: () {
                if (!_signing) {
                  // _login();
                  switchAnimatedWidget();
                }
              },
              color: AppTheme.green,
              textColor: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: !_signing ? Text("Sing Up") : Container(),
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

  Widget _divider(int height) {
    return Divider(
      color: Colors.transparent,
      height: height.toDouble(),
    );
  }
}

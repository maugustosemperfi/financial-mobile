import 'package:financial/application.dart';
import 'package:financial/authentication/authentication.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:financial/pages/login/login.dart';
import 'package:financial/styling.dart';

class LoginWidgetForm extends StatefulWidget {
  @override
  _LoginWidgetFormState createState() => _LoginWidgetFormState();
}

class _LoginWidgetFormState extends State<LoginWidgetForm> {
  // bool _rememberMe = false;
  bool _loging = false;
  bool _autovalidate = false;
  Widget _animatedWiget;
  LoginBloc _loginBloc;

  final loginForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _animatedWiget = _textSignInButton();
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

  _login() {
    if (loginForm.currentState.validate()) {
      loginForm.currentState.save();
      setState(() {
        this._loging = true;
      });
      this.switchAnimatedWidget();

      _loginBloc.add(LoginButtonPressed(
          email: emailController.text, password: passwordController.text));
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  _validationFails() {
    setState(() {
      this._loging = false;
      this._autovalidate = true;
    });
    this.switchAnimatedWidget();
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(listener: (context, state) {
          if (state is LoginFailure) {
            _validationFails();
          }
        }),
        BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
          if (state is AuthenticationAuthenticated) {
            Application.router.navigateTo(context, '/home',
                transition: TransitionType.cupertino, replace: true);
          }
        }),
      ],
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          return Column(
            children: <Widget>[
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
          );
        },
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
    return Form(
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
          )
        ],
      ),
    );
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
                if (!_loging) {
                  _login();
                }
              },
              color: AppTheme.green,
              textColor: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: !_loging ? Text("Login") : Container(),
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

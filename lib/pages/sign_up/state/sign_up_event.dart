import 'package:equatable/equatable.dart';
import 'package:financial/model/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  SignUpEvent([List props = const <dynamic>[]]) : super(props);
}

class SignUpButtonPressed extends SignUpEvent {
  final User user;

  SignUpButtonPressed({this.user}) : super([user]);

  @override
  String toString() {
    return "SignInButtonPressed";
  }
}

class TapBackToLoginButton extends SignUpEvent {
  @override
  String toString() {
    return "TapBackToLoginButton";
  }
}

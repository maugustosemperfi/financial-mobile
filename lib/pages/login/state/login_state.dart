import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  LoginState([List props = const <dynamic>[]]) : super(props);
}

class LoginInitial extends LoginState {
  @override
  String toString() {
    return "LoginInitial";
  }
}

class LoginLoading extends LoginState {
  @override
  String toString() {
    return "LoginLoading";
  }
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error}) : super([error]);

  @override
  String toString() {
    return "LoginFailure";
  }
}

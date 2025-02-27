import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SignUpState extends Equatable {
  SignUpState([List props = const <dynamic>[]]) : super(props);
}

class SignUpInitial extends SignUpState {
  @override
  String toString() {
    return "SignUpInitial";
  }
}

class SignUpLoading extends SignUpState {
  @override
  String toString() {
    return "SignUpLoading";
  }
}

class SignUpSuccess extends SignUpState {
  @override
  String toString() {
    return "SignUpSuccess";
  }
}

class SignUpFail extends SignUpState {
  @override
  String toString() {
    return "SignUpFail";
  }
}

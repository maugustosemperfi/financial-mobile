import 'package:financial/model/category.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() {
    return "AppStarted";
  }
}

class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({@required this.token}) : super([token]);

  @override
  String toString() {
    return "LoggedIn {token: $token";
  }
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() {
    return "LoggedOut";
  }
}

class LoadedBasicItems extends AuthenticationEvent {
  final List<Category> categories;

  LoadedBasicItems({@required this.categories}) : super([categories]);

  @override
  String toString() {
    return "LoadedBasicItems";
  }
}

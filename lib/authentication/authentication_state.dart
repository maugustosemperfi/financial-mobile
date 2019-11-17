import 'package:equatable/equatable.dart';
import 'package:financial/model/category.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const <dynamic>[]]) : super(props);
}

class AuthenticationUnitialized extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnitialized';
}

class AuthenticationAuthenticated extends AuthenticationState {
  final List<Category> categories;

  AuthenticationAuthenticated({@required this.categories})
      : super([categories]);

  @override
  String toString() => 'AuthenticationUnitialized';
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnauthenticated';
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() => 'AuthenticationUnitialized';
}

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class OverviewState extends Equatable {
  OverviewState([List props = const <dynamic>[]]) : super(props);
}

class OverviewLoading extends OverviewState {
  @override
  String toString() {
    return "OverviewLoading";
  }
}

class OverviewLoaded extends OverviewState {
  final bool hideBalance;

  OverviewLoaded({this.hideBalance}) : super([hideBalance]);

  @override
  String toString() {
    return "OverviewLoaded";
  }
}

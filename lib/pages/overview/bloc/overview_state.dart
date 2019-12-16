import 'package:equatable/equatable.dart';
import 'package:financial/model/overview_account.dart';
import 'package:meta/meta.dart';

@immutable
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
  final OverviewAccount overviewAccount;

  OverviewLoaded({this.hideBalance, this.overviewAccount})
      : super([hideBalance, overviewAccount]);

  @override
  String toString() {
    return "OverviewLoaded";
  }
}

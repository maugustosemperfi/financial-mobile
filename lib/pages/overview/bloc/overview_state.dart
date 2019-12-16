import 'package:equatable/equatable.dart';
import 'package:financial/model/overview_account.dart';
import 'package:financial/model/overview_credit_card.dart';
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
  final OverviewCreditCard overviewCreditCard;

  OverviewLoaded(
      {this.hideBalance, this.overviewAccount, this.overviewCreditCard})
      : super([hideBalance, overviewAccount, overviewCreditCard]);

  @override
  String toString() {
    return "OverviewLoaded";
  }
}

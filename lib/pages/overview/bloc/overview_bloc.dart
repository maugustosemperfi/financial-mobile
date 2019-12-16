import 'package:bloc/bloc.dart';
import 'package:financial/pages/overview/bloc/overview_event.dart';
import 'package:financial/pages/overview/bloc/overview_state.dart';
import 'package:financial/services/accounts_service.dart';
import 'package:financial/services/credit_card_service.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  @override
  OverviewState get initialState => OverviewLoaded();

  @override
  Stream<OverviewState> mapEventToState(
    OverviewEvent event,
  ) async* {
    if (event is HideBalance) {
      OverviewLoaded currentState = state;
      yield OverviewLoaded(
        hideBalance: true,
        overviewAccount: currentState.overviewAccount,
        overviewCreditCard: currentState.overviewCreditCard,
      );
    }

    if (event is ShowBalance) {
      OverviewLoaded currentState = state;
      yield OverviewLoaded(
        hideBalance: false,
        overviewAccount: currentState.overviewAccount,
        overviewCreditCard: currentState.overviewCreditCard,
      );
    }

    if (event is LoadOverview) {
      OverviewLoaded currentState = state;
      final overviewAccount = await AccountsService.getOverview();
      final overviewCreditCard = await CreditCardService.overview();

      yield OverviewLoaded(
        hideBalance: currentState.hideBalance,
        overviewAccount: overviewAccount,
        overviewCreditCard: overviewCreditCard,
      );
    }
  }
}

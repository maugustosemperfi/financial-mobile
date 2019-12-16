import 'package:bloc/bloc.dart';
import 'package:financial/pages/overview/bloc/overview_event.dart';
import 'package:financial/pages/overview/bloc/overview_state.dart';
import 'package:financial/services/accounts_service.dart';

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
          hideBalance: true, overviewAccount: currentState.overviewAccount);
    }

    if (event is ShowBalance) {
      OverviewLoaded currentState = state;
      yield OverviewLoaded(
          hideBalance: false, overviewAccount: currentState.overviewAccount);
    }

    if (event is LoadOverview) {
      OverviewLoaded currentState = state;
      final overviewAccount = await AccountsService.getOverview();

      yield OverviewLoaded(
          hideBalance: currentState.hideBalance,
          overviewAccount: overviewAccount);
    }
  }
}

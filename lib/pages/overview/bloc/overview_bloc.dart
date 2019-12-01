import 'package:bloc/bloc.dart';
import 'package:financial/pages/overview/bloc/overview_event.dart';
import 'package:financial/pages/overview/bloc/overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  @override
  OverviewState get initialState => OverviewLoaded();

  @override
  Stream<OverviewState> mapEventToState(
    OverviewEvent event,
  ) async* {
    if (event is HideBalance) {
      yield OverviewLoaded(hideBalance: true);
    }

    if (event is ShowBalance) {
      yield OverviewLoaded(hideBalance: false);
    }
  }
}

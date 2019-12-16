import 'package:bloc/bloc.dart';
import 'package:financial/model/record_group.dart';
import 'package:financial/pages/transactions/state/transactions_event.dart';
import 'package:financial/pages/transactions/state/transactions_state.dart';
import 'package:financial/services/records_service.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  @override
  TransactionsState get initialState => TransactionsInitial();

  @override
  Stream<TransactionsState> mapEventToState(
    TransactionsEvent event,
  ) async* {
    if (event is SearchRecords) {
      try {
        yield TransactionsLoading();
        final List<RecordGroup> records =
            await RecordsService.getTransactionsRecords(event.date);

        yield TransactionsLoaded(records: records, searchDate: event.date);
      } catch (e) {
        yield TransactionsLoaded(records: []);
      }
    }
  }
}

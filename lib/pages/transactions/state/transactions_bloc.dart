import 'package:bloc/bloc.dart';
import 'package:financial/pages/transactions/state/transactions_event.dart';
import 'package:financial/pages/transactions/state/transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  @override
  TransactionsState get initialState => TransactionsInitial();

  @override
  Stream<TransactionsState> mapEventToState(
    TransactionsEvent event,
  ) async* {
    if (event is SearchRecords) {
      print("Hey there, we are making a request for records");
    }
  }
}

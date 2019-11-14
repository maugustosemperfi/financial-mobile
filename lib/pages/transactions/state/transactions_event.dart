import 'package:equatable/equatable.dart';
import 'package:financial/model/record.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TransactionsEvent extends Equatable {
  TransactionsEvent([List props = const <dynamic>[]]) : super(props);
}

class SearchRecords extends TransactionsEvent {
  final DateTime date;

  SearchRecords({this.date}) : super([date]);

  @override
  String toString() {
    return "TransactionEvent - SearchRecords";
  }
}

import 'package:equatable/equatable.dart';
import 'package:financial/model/record.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TransactionsEvent extends Equatable {
  TransactionsEvent([List props = const <dynamic>[]]) : super(props);
}

class SearchRecords extends TransactionsEvent {
  final String filter;

  SearchRecords({this.filter}) : super([filter]);

  @override
  String toString() {
    return "TransactionEvent - SearchRecords";
  }
}

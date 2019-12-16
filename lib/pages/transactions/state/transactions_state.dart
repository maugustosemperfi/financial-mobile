import 'package:equatable/equatable.dart';
import 'package:financial/model/record_group.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TransactionsState extends Equatable {
  TransactionsState([List props = const <dynamic>[]]) : super(props);
}

class TransactionsInitial extends TransactionsState {
  @override
  String toString() {
    return "TransactionsInitial";
  }
}

class TransactionsLoading extends TransactionsState {
  @override
  String toString() {
    return "TransactionsLoading";
  }
}

class TransactionsLoaded extends TransactionsState {
  final List<RecordGroup> records;
  final DateTime searchDate;

  TransactionsLoaded({this.records, this.searchDate})
      : super([records, searchDate]);

  @override
  String toString() {
    return "TransactionsLoaded";
  }
}

import 'package:equatable/equatable.dart';
import 'package:financial/model/record.dart';
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
  final List<Record> records;

  TransactionsLoaded({this.records}) : super([records]);

  @override
  String toString() {
    return "TransactionsLoaded";
  }
}

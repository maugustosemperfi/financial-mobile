import 'package:financial/pages/transactions/state/transactions_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsRecords extends StatefulWidget {
  @override
  _TransactionsRecordsState createState() => _TransactionsRecordsState();
}

class _TransactionsRecordsState extends State<TransactionsRecords> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of(context).dispatch(SearchRecords(filter: ""));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

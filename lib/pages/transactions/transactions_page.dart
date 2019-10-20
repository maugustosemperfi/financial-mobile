import 'package:financial/pages/transactions/state/transactions_bloc.dart';
import 'package:financial/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: Text("Transactions"),
      ),
      body: BlocProvider(
        builder: (BuildContext context) {
          return TransactionsBloc();
        },
        child: Container(),
      ),
    );
  }
}

import 'package:financial/pages/transactions/state/transactions_bloc.dart';
import 'package:financial/pages/transactions/state/transactions_event.dart';
import 'package:financial/pages/transactions/state/transactions_state.dart';
import 'package:financial/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.primary,
            title: Text("Transactions"),
          ),
          body: Container(
            child: RaisedButton(
              child: Text("Hi there"),
              onPressed: () {
                BlocProvider.of<TransactionsBloc>(context)
                    .dispatch(SearchRecords(filter: "123"));
              },
            ),
          ),
        );
      },
    );
  }
}

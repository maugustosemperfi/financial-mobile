import 'package:financial/pages/transactions/state/transactions_bloc.dart';
import 'package:financial/pages/transactions/state/transactions_event.dart';
import 'package:financial/pages/transactions/state/transactions_state.dart';
import 'package:financial/pages/transactions/widgets/transactions_moth.dart';
import 'package:financial/pages/transactions/widgets/transactions_records.dart';
import 'package:financial/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TransactionsBloc>(context)
        .dispatch(SearchRecords(filter: ""));

    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.primary,
            title: Text("Transactions"),
          ),
          body: Column(
            children: <Widget>[
              TransactionsMonthWidget(),
              Expanded(
                child: TransactionsRecords(),
              )
            ],
          ),
        );
      },
    );
  }
}

import 'package:financial/pages/transactions/state/transactions_bloc.dart';
import 'package:financial/pages/transactions/state/transactions_event.dart';
import 'package:financial/pages/transactions/state/transactions_state.dart';
import 'package:financial/pages/transactions/widgets/transactions_moth.dart';
import 'package:financial/pages/transactions/widgets/transactions_records.dart';
import 'package:financial/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsExecuteBloc extends StatefulWidget {
  @override
  _TransactionsExecuteBlocState createState() =>
      _TransactionsExecuteBlocState();
}

class _TransactionsExecuteBlocState extends State<TransactionsExecuteBloc>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<TransactionsBloc>(
      builder: (context) => TransactionsBloc(),
      child: TransactionsPage(),
    );
  }
}

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          appBar: AppBar(
            backgroundColor: AppTheme.primary,
            title: Text("Transactions"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {},
              )
            ],
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

import 'package:financial/pages/transactions/state/transactions_bloc.dart';
import 'package:financial/pages/transactions/state/transactions_state.dart';
import 'package:financial/pages/transactions/widgets/transactions_moth.dart';
import 'package:financial/pages/transactions/widgets/transactions_records.dart';
import 'package:financial/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
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

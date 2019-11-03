import 'package:financial/model/record.dart';
import 'package:financial/pages/transactions/state/transactions_bloc.dart';
import 'package:financial/pages/transactions/state/transactions_event.dart';
import 'package:financial/pages/transactions/state/transactions_state.dart';
import 'package:financial/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsRecords extends StatefulWidget {
  @override
  _TransactionsRecordsState createState() => _TransactionsRecordsState();
}

class _TransactionsRecordsState extends State<TransactionsRecords> {
  List<Record> _records = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionsBloc, TransactionsState>(
      listener: (context, state) {
        if (state is TransactionsLoaded) {
          setState(() {
            _records = state.records;
          });
        }
      },
      child: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: _records.map((record) {
            return ListTile(
              leading: Icon(Icons.drafts),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (record.creditCard != null)
                    Container(
                      child: Icon(
                        Icons.credit_card,
                        color: AppTheme.green,
                      ),
                      padding: EdgeInsets.only(right: 8),
                    ),
                  Expanded(
                    child: Text(record.description),
                  ),
                  Text('${record.value}', style: record.value > 0 ? AppTheme.titleMoneyPositivite : AppTheme.titleMoneyNegative,)
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(record.creditCard != null ? record.creditCard.name : record.account.name, style: AppTheme.caption,)
                ],
              ),
            );
          }),
        ).toList(),
      ),
    );
  }
}

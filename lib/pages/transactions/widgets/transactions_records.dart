import 'package:financial/model/record.dart';
import 'package:financial/model/record_group.dart';
import 'package:financial/pages/transactions/state/transactions_bloc.dart';
import 'package:financial/pages/transactions/state/transactions_event.dart';
import 'package:financial/pages/transactions/state/transactions_state.dart';
import 'package:financial/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class TransactionsRecords extends StatefulWidget {
  @override
  _TransactionsRecordsState createState() => _TransactionsRecordsState();
}

class _TransactionsRecordsState extends State<TransactionsRecords> {
  List<RecordGroup> _records = [];
  bool loading;
  final formatter = new DateFormat.MMMMEEEEd();

  @override
  void initState() {
    super.initState();
    loading = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionsBloc, TransactionsState>(
      listener: (context, state) {
        if (state is TransactionsLoading) {
          setState(() {
            loading = true;
          });
        }
        if (state is TransactionsLoaded) {
          setState(() {
            loading = false;
            _records = state.records;
          });
        }
      },
      child: loading
          ? ListView(
              children: <Widget>[
                ...getParentShimmer(4),
                ...getParentShimmer(2),
                ...getParentShimmer(3),
                ...getParentShimmer(1)
              ],
            )
          : ListView(
              children: ListTile.divideTiles(
                      context: context, tiles: getListTiles(_records))
                  .toList(),
            ),
    );
  }

  getParentShimmer(children) {
    List<Widget> shimmers = [];

    shimmers.add(Shimmer.fromColors(
      baseColor: AppTheme.shimmerStart,
      highlightColor: AppTheme.shimmerEnd,
      child: ListTile(
        title: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: AppTheme.shimmerStart,
                height: 16,
              ),
            )
          ],
        ),
      ),
    ));

    for (var i = 0; i < children; i++) {
      shimmers.add(Shimmer.fromColors(
        baseColor: AppTheme.shimmerStart,
        highlightColor: AppTheme.shimmerEnd,
        child: ListTile(
          leading: CircleAvatar(
            child: Container(
              color: AppTheme.shimmerStart,
              height: 24,
              width: 24,
            ),
          ),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: AppTheme.shimmerStart,
                  height: 28,
                ),
              )
            ],
          ),
        ),
      ));
    }

    return shimmers;
  }

  getListTiles(List<RecordGroup> recordsGroup) {
    List<ListTile> tiles = [];

    recordsGroup.forEach((recordGroup) {
      tiles.add(ListTile(
        title: Text(
          '${formatter.format(recordGroup.recordDay)}',
          style: AppTheme.caption,
        ),
      ));

      recordGroup.records.forEach((record) {
        tiles.add(getRecordListTile(record));
      });
    });

    return tiles;
  }

  getRecordListTile(Record record) {
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
          Text(
            '${record.value}',
            style: record.value > 0
                ? AppTheme.titleMoneyPositivite
                : AppTheme.titleMoneyNegative,
          )
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            record.creditCard != null
                ? record.creditCard.name
                : record.account.name,
            style: AppTheme.caption,
          )
        ],
      ),
    );
  }
}

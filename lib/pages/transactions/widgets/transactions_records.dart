import 'package:financial/model/record.dart';
import 'package:financial/model/record_group.dart';
import 'package:financial/pages/add_record/add_record_page.dart';
import 'package:financial/pages/transactions/state/transactions_bloc.dart';
import 'package:financial/pages/transactions/state/transactions_event.dart';
import 'package:financial/pages/transactions/state/transactions_state.dart';
import 'package:financial/styling.dart';
import 'package:financial/widgets/dixty_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class TransactionsRecords extends StatefulWidget {
  @override
  _TransactionsRecordsState createState() => _TransactionsRecordsState();
}

class _TransactionsRecordsState extends State<TransactionsRecords> {
  List<RecordGroup> _records = [];
  bool _loading;
  TransactionsBloc _transactionsBloc;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final formatter = DateFormat.MMMMEEEEd();
  final dayMonthYearFormatter = DateFormat('dd/MM/yyyy');
  final _editButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loading = true;
  }

  _showRecordsDetail(Record record) {
    showModalBottomSheet(
        context: context,
        backgroundColor: AppTheme.nearlyWhite,
        builder: (BuildContext context) {
          return buildBottomSheet(record);
        });
  }

  _navigateToAddRecordPage(Record record) {
    Navigator.of(context)
        .push(AddRecordPage.route(context, _editButtonKey, true, record));
  }

  void _onRefresh() async {
    _transactionsBloc.add(SearchRecords(date: DateTime.now()));
  }

  void _transactionsLoaded(TransactionsLoaded state) async {
    setState(() {
      _loading = false;
      _records = state.records;
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    _transactionsBloc = BlocProvider.of<TransactionsBloc>(context);
    return BlocListener<TransactionsBloc, TransactionsState>(
      listener: (context, state) {
        if (state is TransactionsLoading) {
          setState(() {
            _loading = true;
          });
        }
        if (state is TransactionsLoaded) {
          _transactionsLoaded(state);
        }
      },
      child: ScrollConfiguration(
        behavior: DixtyScrollBehavior(),
        child: SmartRefresher(
          enablePullUp: false,
          enableTwoLevel: false,
          enablePullDown: true,
          header: MaterialClassicHeader(
            backgroundColor: AppTheme.nearlyWhite,
            color: AppTheme.green,
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: _loading
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
                  padding: EdgeInsets.only(bottom: 64),
                ),
        ),
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
      onTap: () {
        _showRecordsDetail(record);
      },
      leading: CircleAvatar(
        backgroundColor: Color(int.parse(record.category.iconColor)),
        child: Icon(
          MdiIcons.fromString(record.category.iconName),
          color: AppTheme.nearlyWhite,
        ),
      ),
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
            child: Text(record.description.length > 0
                ? record.description
                : record.category.description),
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

  buildBottomSheet(Record record) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 32,
              bottom: 16,
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: CircleAvatar(
                        backgroundColor: AppTheme.green,
                        radius: 24,
                        child: Icon(
                          Icons.attach_money,
                          color: AppTheme.nearlyWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Color(int.parse(record.category.iconColor)),
                  child: Icon(
                    MdiIcons.fromString(record.category.iconName),
                    color: AppTheme.nearlyWhite,
                    size: 32,
                  ),
                ),
                GestureDetector(
                  key: _editButtonKey,
                  onTap: () {
                    _navigateToAddRecordPage(record);
                  },
                  child: CircleAvatar(
                    backgroundColor: AppTheme.whiteGrey,
                    radius: 24,
                    child: Icon(
                      Icons.edit,
                      color: AppTheme.mediumGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              record.description,
              textAlign: TextAlign.center,
              style: AppTheme.headlineBlack,
            ),
          ),
          Container(
            child: Text(
              'R\$ ${record.value}',
              textAlign: TextAlign.center,
              style: AppTheme.headlineGrey,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Date",
                      style: AppTheme.caption,
                    ),
                    Text(
                      dayMonthYearFormatter.format(record.recordDate),
                      style: AppTheme.captionBold,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      record.account != null ? "Account" : "Credit card",
                      style: AppTheme.caption,
                    ),
                    Text(
                      record.account != null
                          ? record.account.name
                          : record.creditCard.name,
                      style: AppTheme.captionBold,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Category",
                      style: AppTheme.caption,
                    ),
                    Text(
                      record.category.description,
                      style: AppTheme.captionBold,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

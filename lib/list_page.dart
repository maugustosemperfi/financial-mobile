import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:reply/model/email_model.dart';
import 'package:reply/styling.dart';
import 'package:reply/transition/scale_out_transition.dart';
import 'package:reply/ui/list_item.dart';

class ListPage extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailModel>(
      builder: (BuildContext context, EmailModel model, Widget child) {
        return ScaleOutTransition(
          child: Material(
            child: SmartRefresher(
              enablePullUp: true,
              enableTwoLevel: false,
              header: MaterialClassicHeader(
                backgroundColor: AppTheme.nearlyWhite,
                color: AppTheme.green,
              ),
              controller: _refreshController,
              onLoading: _onLoading,
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: model.emails.length,
                itemBuilder: (BuildContext context, int position) {
                  return ListItem(
                    id: position,
                    email: model.emails[position],
                    onDeleted: () => model.deleteEmail(position),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

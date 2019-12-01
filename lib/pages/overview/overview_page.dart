import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial/pages/overview/widgets/accounts_widget.dart';
import 'package:financial/pages/overview/widgets/alert_widget.dart';
import 'package:financial/pages/overview/widgets/credit_card_widget.dart';
import 'package:financial/styling.dart';
import 'package:financial/widgets/dixty_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Overview"),
        backgroundColor: AppTheme.primary,
      ),
      body: ScrollConfiguration(
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
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Stack(
                  children: <Widget>[
                    CarouselSlider(
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      enlargeCenterPage: false,
                      items: <Widget>[
                        AlertWidget(
                          iconData: Icons.subscriptions,
                          text: "You have 1 bill to pay totalizing R\$ 51,58",
                        ),
                        AlertWidget(
                          iconData: Icons.payment,
                          text: "You have 1 bill to pay totalizing R\$ 102,58",
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: AccountsWidget(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: CreditCardWidget(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

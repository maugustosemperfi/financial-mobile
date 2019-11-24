import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial/pages/overview/widgets/accounts_widget.dart';
import 'package:financial/pages/overview/widgets/alert_widget.dart';
import 'package:financial/pages/overview/widgets/credit_card_widget.dart';
import 'package:financial/styling.dart';
import 'package:flutter/material.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
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
    );
  }
}

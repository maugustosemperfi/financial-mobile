import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:reply/pages/overview/widgets/accounts_widget.dart';
import 'package:reply/pages/overview/widgets/alert_widget.dart';
import 'package:reply/pages/overview/widgets/credit_card_widget.dart';
import 'package:reply/styling.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
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
                  enlargeCenterPage: true,
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
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Accounts",
                          style: AppTheme.title,
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 12,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "R\$ 18.192,49",
                          style: AppTheme.display2,
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 16,
                    ),
                    AccountsWidget(
                      accountName: "Inter",
                      iconData: Icons.monetization_on,
                      savings: 123.47,
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 16,
                    ),
                    AccountsWidget(
                      accountName: "Itau",
                      iconData: Icons.monetization_on,
                      savings: 2433.47,
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 16,
                    ),
                    AccountsWidget(
                      accountName: "Cash",
                      iconData: Icons.monetization_on,
                      savings: 532.47,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Credit cards",
                          style: AppTheme.title,
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 12,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "R\$ 8.544,23",
                          style: AppTheme.display2,
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 16,
                    ),
                    CreditCardWidget(
                      iconData: Icons.airplay,
                      accountName: "Itau",
                      creditCardName: "Itau international",
                      available: 2084.32,
                      statement: 3088.90,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

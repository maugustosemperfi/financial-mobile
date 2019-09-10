import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:reply/pages/overview/widgets/alert_widget.dart';

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
          Stack(
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
          )
        ],
      ),
    );
  }
}

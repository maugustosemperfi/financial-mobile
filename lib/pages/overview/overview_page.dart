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
        children: <Widget>[AlertWidget()],
      ),
    );
  }
}

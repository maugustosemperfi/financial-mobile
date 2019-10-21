import 'package:financial/styling.dart';
import 'package:flutter/material.dart';

class TransactionsMonthWidget extends StatefulWidget {
  @override
  _TransactionsMonthWidgetState createState() =>
      _TransactionsMonthWidgetState();
}

class _TransactionsMonthWidgetState extends State<TransactionsMonthWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FlatButton(
          child: Icon(Icons.keyboard_arrow_left),
          onPressed: () {},
        ),
        Expanded(
          child: FlatButton(
            child: Text(
              "October 2019",
              style: AppTheme.body1,
            ),
            onPressed: () {},
          ),
        ),
        FlatButton(
          child: Icon(Icons.keyboard_arrow_right),
          onPressed: () {},
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:financial/styling.dart';

class CreditCardWidget extends StatelessWidget {
  IconData iconData;
  String accountName;
  String creditCardName;
  double available;
  double statement;

  CreditCardWidget(
      {this.iconData,
      this.accountName,
      this.creditCardName,
      this.available,
      this.statement}) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 16),
            child: Icon(iconData, color: AppTheme.green,),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          accountName,
                          style: AppTheme.caption,
                        ),
                        Text(
                          creditCardName,
                          style: AppTheme.title,
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.transparent,
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Available",
                          style: AppTheme.caption,
                        ),
                        Text("R\$ ${available}", style: AppTheme.body1)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Statement", style: AppTheme.caption),
                        Text("R\$ -${statement}", style: AppTheme.title)
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

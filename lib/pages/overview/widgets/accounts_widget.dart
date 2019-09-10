import 'package:flutter/material.dart';
import 'package:reply/styling.dart';

class AccountsWidget extends StatelessWidget {
  IconData iconData;
  String accountName;
  double savings;

  AccountsWidget({this.iconData, this.accountName, this.savings}) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconData,
            color: AppTheme.green,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  accountName,
                  style: AppTheme.title,
                ),
                Text(
                  "Checking account",
                  style: AppTheme.caption,
                )
              ],
            ),
          ),
          Text(
            "R\$ ${savings}",
            style: AppTheme.titleMoneyPositivite,
          ),
        ],
      ),
    );
  }
}

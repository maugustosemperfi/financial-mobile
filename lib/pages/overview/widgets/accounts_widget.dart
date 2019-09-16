import 'dart:convert';

import 'package:financial/application.dart';
import 'package:financial/model/account.dart';
import 'package:financial/styling.dart';
import 'package:flutter/material.dart';

class AccountsWidget extends StatefulWidget {
  AccountsWidget();

  @override
  _AccountsWidgetState createState() => _AccountsWidgetState();
}

class _AccountsWidgetState extends State<AccountsWidget> {
  List<Account> _accounts = [];

  @override
  void initState() {
    super.initState();
    _getAccounts();
  }

  _getAccounts() async {
    final accountsResponse = await Application.dio.get('accounts');

    final List<Account> accounts = new List<Account>.from(
        jsonDecode(accountsResponse.data) as List<dynamic>
          ..map((account) => Account.fromJson(account)));

    setState(() {
      this._accounts = accounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _accounts.length > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Accounts",
                      style: AppTheme.title,
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 12,
                    ),
                    Text(
                      "R\$ 0",
                      style: AppTheme.display2,
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "You don't have any account",
                      style: AppTheme.title,
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: 12,
                    ),
                  ],
                ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _accounts.map((account) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.monetization_on,
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
                            "",
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
                      "R\$ $account.",
                      style: AppTheme.titleMoneyPositivite,
                    )
                  ],
                ),
              );
            }).toList(),
          ),
          Divider(
            color: Colors.transparent,
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {},
                  textColor: AppTheme.nearlyWhite,
                  color: AppTheme.green,
                  child: Text(
                    "Add acount",
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

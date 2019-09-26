import 'dart:convert';

import 'package:financial/application.dart';
import 'package:financial/enum/enum_account_type.dart';
import 'package:financial/model/account.dart';
import 'package:financial/model/overview_account.dart';
import 'package:financial/services/accounts_service.dart';
import 'package:financial/styling.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AccountsWidget extends StatefulWidget {
  AccountsWidget();

  @override
  _AccountsWidgetState createState() => _AccountsWidgetState();
}

class _AccountsWidgetState extends State<AccountsWidget> {
  List<Account> _accounts = [];
  OverviewAccount _overviewAccount;

  @override
  void initState() {
    super.initState();
    // _getAccounts();
    _getAccountsOverview();
  }

  _getAccounts() async {
    // final accountsResponse = await Application.dio.get('accounts');

    // final List<Account> accounts = (jsonDecode(accountsResponse.data) as List)
    //     .map((account) => Account.fromJson(account))
    //     .toList();

    // setState(() {
    //   this._accounts = accounts;
    // });
  }

  _getAccountsOverview() async {
    final overviewAccountJson = await AccountsService.getOverview();

    final overviewAccount =
        OverviewAccount.fromJson(jsonDecode(overviewAccountJson.data));

    setState(() {
      _overviewAccount = overviewAccount;
    });
  }

  _showAccountBottomSheet(BuildContext context) {
    print("");
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createTile(context, 'Checking account', Icons.account_balance,
                  EnumAccountType.checking.index),
            ],
          );
        });
  }

  _openAddAcountPage() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _overviewAccount != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Accounts",
                      style: AppTheme.title,
                    ),
                    Text(
                      "R\$ ${this._overviewAccount.overallBalance}",
                      style: AppTheme.title,
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
          Divider(height: 12, color: Colors.transparent),
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: _overviewAccount != null
                ? _overviewAccount.accounts.map((account) {
                    return Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.monetization_on,
                                    color: AppTheme.green,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "${account.name}",
                                        style: AppTheme.title,
                                      ),
                                      Text(
                                        "Checking account",
                                        style: AppTheme.caption,
                                      )
                                    ],
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  ),
                                  Text(
                                    "R\$ ${account.realValue}",
                                    style: AppTheme.titleMoneyPositivite,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 12,
                          color: Colors.transparent,
                        ),
                      ],
                    );
                  }).toList()
                : [],
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
                  onPressed: () => {_showAccountBottomSheet(context)},
                  textColor: AppTheme.nearlyWhite,
                  color: AppTheme.primary,
                  child: Text(
                    "Add acount",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ListTile _createTile(
      BuildContext context, String name, IconData icon, int type) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        Application.router.navigateTo(context, 'account/add/$type',
            transition: TransitionType.cupertinoFullScreenDialog);
      },
    );
  }
}

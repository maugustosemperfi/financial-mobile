import 'dart:convert';

import 'package:financial/application.dart';
import 'package:financial/enum/enum_account_type.dart';
import 'package:financial/model/overview_account.dart';
import 'package:financial/pages/overview/bloc/overview_bloc.dart';
import 'package:financial/pages/overview/bloc/overview_state.dart';
import 'package:financial/services/accounts_service.dart';
import 'package:financial/styling.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';

class AccountsWidget extends StatefulWidget {
  AccountsWidget();

  @override
  _AccountsWidgetState createState() => _AccountsWidgetState();
}

class _AccountsWidgetState extends State<AccountsWidget> {
  OverviewAccount _overviewAccount;
  var tapPosition;

  @override
  void initState() {
    super.initState();
  }

  _showAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createTile(context, 'Checking account', Icons.account_balance,
                  EnumAccountType.checking),
              _createTile(context, 'Saving or investments',
                  Icons.account_balance, EnumAccountType.saving),
              _createTile(context, 'Others', Icons.account_balance,
                  EnumAccountType.others),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OverviewBloc, OverviewState>(
      listener: (context, state) {
        print(state.toString() + "13213321");
        if (state is OverviewLoaded) {
          setState(() {
            _overviewAccount = state.overviewAccount;
          });
        }
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _overviewAccount != null
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
            ),
            Divider(height: 12, color: Colors.transparent),
            _accountsOverview,
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
      ),
    );
  }

  get _accountsOverview {
    return Column(
      children: ListTile.divideTiles(
              context: context,
              tiles: _overviewAccount != null
                  ? _overviewAccount.accounts.map((account) {
                      return InkWell(
                        onTapDown: (TapDownDetails details) {
                          tapPosition = tapPosition = details.globalPosition;
                        },
                        onLongPress: () async {
                          showMenuOnLongPress(context, tapPosition);
                        },
                        child: ListTile(
                          leading: Image.network(
                            account.bank.iconUrl,
                            height: 36,
                          ),
                          title: Text(
                            "${account.name}",
                            style: AppTheme.title,
                          ),
                          subtitle: Text(
                            AccountType.getAccountNameByAccountType(
                                account.type),
                            style: AppTheme.caption,
                            // style: AppTheme.caption,
                          ),
                          trailing: Text(
                            "R\$ ${account.realValue}",
                            style: AppTheme.titleMoneyPositivite,
                          ),
                        ),
                      );
                    })
                  : [])
          .toList(),
    );
  }

  void showMenuOnLongPress(BuildContext context, tapPosition) {
    Vibration.vibrate(duration: 10);
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    showMenu(
        context: context,
        position: RelativeRect.fromRect(
            tapPosition & Size(40, 40), // smaller rect, the touch area
            Offset.zero & overlay.size // Bigger rect, the entire screen
            ),
        items: <PopupMenuEntry>[
          PopupMenuItem(
            value: 1,
            child: Row(
              children: <Widget>[
                Icon(Icons.delete),
                Text("Delete Account"),
              ],
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: <Widget>[
                Icon(Icons.edit),
                Text("Edit Account"),
              ],
            ),
          )
        ]);
  }

  ListTile _createTile(
      BuildContext context, String name, IconData icon, EnumAccountType type) {
    return ListTile(
      leading: Icon(AccountType.getIconByAccountType(type)),
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        Application.router.navigateTo(context, 'account/add/${type.index}',
            transition: TransitionType.cupertinoFullScreenDialog);
      },
    );
  }
}

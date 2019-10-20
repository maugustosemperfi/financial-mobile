import 'package:financial/application.dart';
import 'package:financial/model/overview_credit_card.dart';
import 'package:financial/services/credit_card_service.dart';
import 'package:financial/styling.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class CreditCardWidget extends StatefulWidget {
  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  OverviewCreditCard _overviewCreditCard;

  @override
  void initState() {
    super.initState();
    _getOverviewCreditCard();
  }

  _getOverviewCreditCard() async {
    final overviewCreditCard = await CreditCardService.overview();

    setState(() {
      _overviewCreditCard = overviewCreditCard;
    });
  }

  _showAddCreditCardPage() {
    Application.router.navigateTo(context, 'credit-card/add',
        transition: TransitionType.cupertinoFullScreenDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _overviewCreditCard != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Credit cards",
                        style: AppTheme.title,
                      ),
                      Text(
                        "R\$ ${this._overviewCreditCard.overallStatement}",
                        style: AppTheme.title,
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "You don't have any credit card",
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
          _creditCardOverview(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () => {_showAddCreditCardPage()},
                  textColor: AppTheme.nearlyWhite,
                  color: AppTheme.primary,
                  child: Text(
                    "Add credit card",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _creditCardOverview() {
    return Column(
      children: ListTile.divideTiles(
              context: context,
              tiles: _overviewCreditCard != null
                  ? _overviewCreditCard.creditCards.map((creditCard) {
                      return InkWell(
                        onTapDown: (TapDownDetails details) {},
                        onLongPress: () async {},
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              dense: true,
                              leading: Image.network(
                                creditCard.bank.iconUrl,
                                height: 36,
                              ),
                              subtitle: Text(
                                creditCard.name,
                                style: AppTheme.title,
                              ),
                              title: Text(
                                "${creditCard.account.name}",
                                style: AppTheme.caption,
                              ),
                            ),
                            ListTile(
                              dense: true,
                              leading: Container(
                                width: 36,
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  creditCard.available < 0
                                      ? Text(
                                          "R\$ ${creditCard.available}",
                                          style: AppTheme.titleMoneyNegative,
                                        )
                                      : Text(
                                          "R\$ ${creditCard.available}",
                                          style: AppTheme.title,
                                        ),
                                  creditCard.statement < 0
                                      ? Text(
                                          "R\$ -${creditCard.statement}",
                                          style: AppTheme.titleMoneyNegative,
                                        )
                                      : Text(
                                          "R\$ ${creditCard.statement}",
                                          style: AppTheme.title,
                                        )
                                ],
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Available",
                                    style: AppTheme.caption,
                                  ),
                                  Text(
                                    "Statement",
                                    style: AppTheme.caption,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    })
                  : [])
          .toList(),
    );
  }
}

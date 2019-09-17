import 'package:financial/application.dart';
import 'package:financial/enum/enum_account_type.dart';
import 'package:financial/model/account.dart';
import 'package:financial/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddAccountPage extends StatefulWidget {
  final EnumAccountType type;

  AddAccountPage({@required this.type});

  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  final _addAccountForm = GlobalKey<FormState>();

  MoneyMaskedTextController _balanceController = MoneyMaskedTextController();
  TextEditingController _accountNameController = TextEditingController();

  _changeBalance() {
    setState(() {
      if (_balanceController.leftSymbol == '') {
        _balanceController = MoneyMaskedTextController(leftSymbol: '-');
      } else {
        _balanceController = MoneyMaskedTextController(leftSymbol: '');
      }
    });
  }

  _addAccount() async {
    print(1);
    Account account = Account.fromJson({
      "balance": _balanceController.numberValue,
      "name": _accountNameController.value.text,
      "type": widget.type
    });
    final application = await Application.dio.post('accounts', data: account);

    print(application);
  }

  bool _balanceNegative() {
    return _balanceController.leftSymbol == '-';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create account"),
        backgroundColor: AppTheme.primary,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsetsDirectional.only(bottom: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Form(
              key: _addAccountForm,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _accountNameController,
                    decoration: InputDecoration(
                        labelText: 'Account name',
                        border: OutlineInputBorder()),
                  ),
                  TextFormField(
                    controller: _balanceController,
                    decoration: InputDecoration(
                      labelText: 'Initial balance',
                      suffix: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            child: _balanceNegative()
                                ? Icon(
                                    Icons.add_circle,
                                    color: AppTheme.green,
                                  )
                                : Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                            onTap: () => {_changeBalance()},
                          )
                        ],
                      ),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: AppTheme.green,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _addAccount();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

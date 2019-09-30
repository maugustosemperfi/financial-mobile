import 'package:financial/application.dart';
import 'package:financial/enum/enum_account_type.dart';
import 'package:financial/model/account.dart';
import 'package:financial/styling.dart';
import 'package:financial/widgets/dixty_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddAccountPage extends StatefulWidget {
  EnumAccountType type;

  AddAccountPage({@required this.type});

  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  final _addAccountForm = GlobalKey<FormState>();

  MoneyMaskedTextController _balanceController = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
  );
  TextEditingController _accountNameController = TextEditingController();

  _changeBalance() {
    print(_balanceController.value.text);
    setState(() {
      _balanceController.updateValue(_balanceController.numberValue * -1);
    });
  }

  _addAccount() async {
    Account account = Account.fromJson({
      "balance": _balanceController.numberValue.toString(),
      "name": _accountNameController.text,
      "type": widget.type.index
    });
    final application =
        await Application.dio.post('accounts', data: account.toJson());


  }

  bool _balanceNegative() {
    return _balanceController.numberValue < 0;
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
                  DixtyTextFormFieldWiget(
                    controller: _accountNameController,
                    labelText: 'Account Name',
                    textCapitalization: TextCapitalization.words,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DixtyTextFormFieldWiget(
                          controller: _balanceController,
                          labelText: 'Initial Balance',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      IconButton(
                        icon: _balanceNegative()
                            ? Icon(
                                Icons.add_circle,
                                color: AppTheme.green,
                              )
                            : Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                        onPressed: () {
                          _changeBalance();
                        },
                      ),
                    ],
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

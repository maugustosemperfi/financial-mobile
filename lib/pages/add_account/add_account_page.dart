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
  TextEditingController _accountTypeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  IconData _accountTypeIcon;
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    _accountTypeController.text =
        AccountType.getAccountNameByAccountType(widget.type);
    _accountTypeIcon = AccountType.getIconByAccountType(widget.type);
  }

  _changeBalance() {
    print(_balanceController.value.text);
    setState(() {
      _balanceController.updateValue(_balanceController.numberValue * -1);
    });
  }

  _addAccount() async {
    if (_addAccountForm.currentState.validate()) {
      _addAccountForm.currentState.save();
      Account account = Account.fromJson({
        "balance": _balanceController.numberValue.toString(),
        "name": _accountNameController.text,
        "type": widget.type.index,
        "description": _descriptionController.value
      });
      final application =
          await Application.dio.post('accounts', data: account.toJson());

      Application.router.pop(context);
    } else {
      _autoValidate = true;
    }
  }

  bool _balanceNegative() {
    return _balanceController.numberValue < 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _addAccountForm,
                autovalidate: _autoValidate,
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: DixtyTextFormFieldWiget(
                        decorationIcon: Icon(_accountTypeIcon),
                        controller: _accountTypeController,
                        labelText: 'Account Type',
                        readOnly: true,
                      ),
                    ),
                    DixtyTextFormFieldWiget(
                      decorationIcon: Icon(Icons.assignment),
                      controller: _accountNameController,
                      labelText: 'Account Name',
                      textCapitalization: TextCapitalization.words,
                      validator: (String accountName) {
                        if (accountName.length == 0) {
                          return 'Account must have a name';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: DixtyTextFormFieldWiget(
                            decorationIcon: Icon(Icons.attach_money),
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
                    DixtyTextFormFieldWiget(
                      decorationIcon: Icon(Icons.description),
                      controller: _descriptionController,
                      labelText: 'Description',
                      hintText: 'Short description of your account',
                    ),
                  ],
                ),
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

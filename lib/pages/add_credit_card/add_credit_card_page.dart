import 'package:financial/model/account.dart';
import 'package:financial/model/bank.dart';
import 'package:financial/services/banks_data.dart';
import 'package:financial/styling.dart';
import 'package:financial/widgets/dixty_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddCreditCardPage extends StatefulWidget {
  @override
  _AddCreditCardPageState createState() => _AddCreditCardPageState();
}

class _AddCreditCardPageState extends State<AddCreditCardPage> {
  final _addCreditCardForm = GlobalKey<FormState>();

  MoneyMaskedTextController _creditLimitController = MoneyMaskedTextController(
    leftSymbol: 'R\$ ',
  );
  TextEditingController _creditCardBankController = TextEditingController();
  TextEditingController _creditCardNameController = TextEditingController();
  TextEditingController _cycleDayController = TextEditingController();
  TextEditingController _dueDayController = TextEditingController();
  TextEditingController _paymentAccountController = TextEditingController();

  Bank _selectedBank;
  Account _selectedAccount;
  bool _autovalidate = false;

  @override
  void initState() {
    super.initState();
    _selectedBank = BanksData.banks[0];
    _creditCardBankController.text = _selectedBank.name;
  }

  Future _selectBank() async {
    final bank = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              "Select bank",
              style: AppTheme.headlineLight,
            ),
            children: <Widget>[
              Column(
                children: ListTile.divideTiles(
                    context: context,
                    tiles: BanksData.banks.map((bank) {
                      return ListTile(
                        title: Text(bank.name),
                        leading: Image.network(
                          bank.iconUrl,
                          height: 36,
                        ),
                        onTap: () {
                          Navigator.pop(context, bank);
                        },
                      );
                    })).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    textColor: AppTheme.primary,
                    child: Text("CANCEL"),
                  )
                ],
              )
            ],
          );
        });
    if (bank != null) {
      _setSelectedBank(bank);
    }
  }

  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        });
    if (picked != null)
      setState(() {
        print(picked);
      });
  }

  _setSelectedBank(Bank bank) {
    setState(() {
      _selectedBank = bank;
      _creditCardBankController.text = bank.name;
    });
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
                key: _addCreditCardForm,
                autovalidate: _autovalidate,
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _selectBank();
                      },
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Image.network(
                                  _selectedBank.iconUrl,
                                  height: 24,
                                ),
                                padding: EdgeInsets.only(right: 16),
                              )
                            ],
                          ),
                          Expanded(
                            child: DixtyTextFormFieldWiget(
                              controller: _creditCardBankController,
                              labelText: 'Credit Card Bank',
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DixtyTextFormFieldWiget(
                      decorationIcon: Icon(Icons.assignment),
                      controller: _creditCardNameController,
                      labelText: 'Account Name',
                      textCapitalization: TextCapitalization.words,
                      validator: (String accountName) {
                        if (accountName.length == 0) {
                          return 'Credit card must have a name';
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: DixtyTextFormFieldWiget(
                            labelText: 'Cycle Day',
                            onTap: () {
                              _selectDate(context);
                            },
                            readOnly: true,
                            controller: _cycleDayController,
                          ),
                        ),
                        Expanded(
                          child: DixtyTextFormFieldWiget(
                            labelText: 'Due Day',
                            onTap: () {
                              _selectDate(context);
                            },
                            readOnly: true,
                            controller: _cycleDayController,
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        _selectBank();
                      },
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: _selectedAccount != null
                                    ? Image.network(
                                        _selectedAccount.bank.iconUrl,
                                        height: 24,
                                      )
                                    : null,
                                padding: EdgeInsets.only(right: 16),
                              )
                            ],
                          ),
                          Expanded(
                            child: DixtyTextFormFieldWiget(
                              controller: _paymentAccountController,
                              labelText: 'Payment Account',
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
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
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:financial/application.dart';
import 'package:financial/enum/enum_record_type.dart';
import 'package:financial/model/account.dart';
import 'package:financial/model/record.dart';
import 'package:financial/services/accounts_data.dart';
import 'package:financial/services/records_service.dart';
import 'package:financial/styling.dart';
import 'package:financial/widgets/dixty_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CreateRecordPage extends StatefulWidget {
  final double balance;
  final EnumRecordType recordType;

  const CreateRecordPage({this.balance, this.recordType});

  @override
  _CreateRecordPageState createState() => _CreateRecordPageState();
}

class _CreateRecordPageState extends State<CreateRecordPage> {
  final createRecordForm = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  Account _simpleAccountSelected;

  MoneyMaskedTextController _controller = MoneyMaskedTextController(
    leftSymbol: '',
    decimalSeparator: ',',
    thousandSeparator: '.',
    initialValue: 000,
  );

  TextEditingController _dateController = TextEditingController();
  TextEditingController _simpleAccountController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.updateValue(widget.balance);
    _setDate(DateTime.now());
    _setAccountSelected(AccountsData.simpleAccounts[0]);
  }

  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        });
    if (picked != null && picked != selectedDate)
      setState(() {
        _setDate(picked);
      });
  }

  _setAccountSelected(Account simpleAccount) {
    setState(() {
      _simpleAccountSelected = simpleAccount;
      _simpleAccountController.text = "${simpleAccount.name}";
    });
  }

  void _setDate(DateTime picked) {
    selectedDate = picked;
    _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
  }

  _createRecord() async {
    Record record = new Record();
    record.description = this._descriptionController.text;
    record.account = this._simpleAccountSelected;
    record.value = this.widget.balance;
    record.createdAt = this.selectedDate;
    record.type = widget.recordType;

    await RecordsService.createRecord(record);

    Application.router.pop(context);
    Application.router.pop(context);
  }

  _navigateToAddPage() {
    print("aa");
    Application.router.pop(context);
  }

  Future _selectAccount() async {
    final accountSelected = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              "Select account",
              style: AppTheme.headlineLight,
            ),
            children: <Widget>[
              Row(
                children: <Widget>[Text("accounts")],
              ),
              Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: AccountsData.simpleAccounts.map((simpleAccount) {
                  return Row(
                    children: <Widget>[
                      FlatButton(
                        child: Text(simpleAccount.name),
                        onPressed: () {
                          Navigator.pop(context, simpleAccount);
                        },
                      )
                    ],
                  );
                }).toList(),
              )
            ],
          );
        });
    _setAccountSelected(accountSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: null,
      body: Material(
        child: SafeArea(
          child: Container(
            color: AppTheme.nearlyWhite,
            padding: EdgeInsets.only(bottom: 36),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                _moneyIndicator,
                _formRecord,
                Expanded(
                  child: Container(),
                ),
                _fab,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _moneyIndicator {
    return GestureDetector(
      onTap: () {
        _navigateToAddPage();
      },
      child: Container(
        padding: EdgeInsets.only(top: 60, bottom: 30),
        color: widget.recordType == EnumRecordType.income
            ? AppTheme.primary
            : AppTheme.warn,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(color: AppTheme.nearlyWhite, fontSize: 50),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _formRecord {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: createRecordForm,
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: DixtyTextFormFieldWiget(
                    decorationIcon: Icon(
                      Icons.calendar_today,
                      color: AppTheme.grey,
                    ),
                    onTap: () {
                      _selectDate(context);
                    },
                    readOnly: true,
                    controller: _dateController,
                  ),
                ),
              ],
            ),
            DixtyTextFormFieldWiget(
              decorationIcon: Icon(Icons.description),
              hintText: "Description",
              controller: _descriptionController,
            ),
            DixtyTextFormFieldWiget(
              decorationIcon: Icon(
                Icons.attach_money,
              ),
              onTap: () {
                _selectAccount();
              },
              controller: _simpleAccountController,
              readOnly: true,
            ),
            DixtyTextFormFieldWiget(
              decorationIcon: Icon(Icons.devices_other),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _fab {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FloatingActionButton(
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
          backgroundColor: widget.recordType == EnumRecordType.income
              ? AppTheme.primary
              : AppTheme.warn,
          onPressed: () {
            _createRecord();
          },
        )
      ],
    );
  }
}

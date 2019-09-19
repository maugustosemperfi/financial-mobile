import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:financial/styling.dart';
import 'package:financial/transition/expand_transition.dart';

class CreateRecordPage extends StatefulWidget {
  final double balance;

  const CreateRecordPage({this.balance});

  @override
  _CreateRecordPageState createState() => _CreateRecordPageState();
}

class _CreateRecordPageState extends State<CreateRecordPage> {
  DateTime selectedDate = DateTime.now();

  MoneyMaskedTextController _controller = new MoneyMaskedTextController(
    leftSymbol: '',
    decimalSeparator: ',',
    thousandSeparator: '.',
    initialValue: 000,
  );

  @override
  void initState() {
    super.initState();
    _controller.updateValue(widget.balance);
  }

  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.green,
        leading: Container(),
        elevation: 0,
      ),
      body: Material(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                _moneyIndicator,
                _formRecord,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _moneyIndicator {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 50),
      color: AppTheme.green,
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
    );
  }

  Widget get _formRecord {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsetsDirectional.only(end: 16),
                  child: Icon(
                    Icons.calendar_today,
                    color: AppTheme.grey,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      suffix: RaisedButton(
                        child: Text("repeat"),
                        onPressed: () {},
                      ),
                    ),
                    onTap: () {
                      _selectDate(context);
                    },
                    readOnly: true,
                  ),
                ),
              ],
            ),
            TextFormField(
                decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.grey)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.grey)),
            )),
            TextFormField(),
          ],
        ),
      ),
    );
  }
}

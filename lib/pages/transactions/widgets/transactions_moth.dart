import 'package:financial/pages/transactions/state/transactions_bloc.dart';
import 'package:financial/pages/transactions/state/transactions_event.dart';
import 'package:financial/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionsMonthWidget extends StatefulWidget {
  @override
  _TransactionsMonthWidgetState createState() =>
      _TransactionsMonthWidgetState();
}

class _TransactionsMonthWidgetState extends State<TransactionsMonthWidget> {
  DateTime _selectedMonth;
  final formatter = DateFormat("MMMM y");
  TransactionsBloc transactionsBloc;

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateTime.now();
  }

  _selectMonth(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedMonth,
        firstDate: DateTime(1901),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        });
    if (picked != null && picked != _selectedMonth) {
      _setDate(picked);
    }
  }

  _changeMonthByArrow(arrowValue) {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year,
          _selectedMonth.month + arrowValue, _selectedMonth.day);
    });

    searchRecords();
  }

  _setDate(DateTime picked) {
    setState(() {
      _selectedMonth = picked;
    });

    searchRecords();
  }

  searchRecords() {
    transactionsBloc.dispatch(SearchRecords(date: _selectedMonth));
  }

  @override
  Widget build(BuildContext context) {
    transactionsBloc = BlocProvider.of<TransactionsBloc>(context);
    return Row(
      children: <Widget>[
        FlatButton(
          child: Icon(Icons.keyboard_arrow_left),
          onPressed: () => _changeMonthByArrow(-1),
        ),
        Expanded(
          child: FlatButton(
            child: Text(
              "${formatter.format(_selectedMonth)}",
              style: AppTheme.body1,
            ),
            onPressed: () => _selectMonth(context),
          ),
        ),
        FlatButton(
          child: Icon(Icons.keyboard_arrow_right),
          onPressed: () => _changeMonthByArrow(1),
        ),
      ],
    );
  }
}

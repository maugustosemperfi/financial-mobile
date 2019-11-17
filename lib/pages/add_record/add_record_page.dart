import 'package:financial/application.dart';
import 'package:financial/enum/enum_record_type.dart';
import 'package:financial/model/record.dart';
import 'package:financial/styling.dart';
import 'package:financial/transition/fab_fill_transition.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage(
      {Key key, @required this.sourceRect, this.editing = false, this.record})
      : assert(sourceRect != null),
        super(key: key);

  static Route<dynamic> route(BuildContext context, GlobalKey key,
      [bool editing, Record record]) {
    final RenderBox box = key.currentContext.findRenderObject();
    final Rect sourceRect = box.localToGlobal(Offset.zero) & box.size;

    return PageRouteBuilder<void>(
      pageBuilder: (BuildContext context, _, __) => AddRecordPage(
        sourceRect: sourceRect,
        editing: editing,
        record: record,
      ),
      transitionDuration: const Duration(milliseconds: 350),
    );
  }

  final Rect sourceRect;
  final bool editing;
  final Record record;

  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  EnumRecordType _recordType = EnumRecordType.income;
  MoneyMaskedTextController _controller = MoneyMaskedTextController(
    leftSymbol: '',
    decimalSeparator: ',',
    thousandSeparator: '.',
    initialValue: 000,
  );

  // final GlobalKey _fabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.record != null) {
      _setRecordType(widget.record.type);
      _controller.updateValue(widget.record.value);
    }
  }

  _setRecordType(EnumRecordType recordType) {
    setState(() {
      _recordType = recordType;
    });
  }

  @override
  Widget build(BuildContext context) {
    String fabIcon = 'assets/images/ic_add.png';

    if (widget.editing) {
      fabIcon = 'assets/images/ic_edit.png';
    }

    return FabFillTransition(
      source: widget.sourceRect,
      icon: fabIcon,
      child: Scaffold(
        appBar: null,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: AppTheme.nearlyWhite,
            child: Material(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _moneyIndicator,
                  _spacer,
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      padding: EdgeInsets.only(top: 60),
                      child: _buttons,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _spacer {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
    );
  }

  Widget get _moneyIndicator {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 60, bottom: 30),
          color: _recordType == EnumRecordType.income
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
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Income",
                        style: AppTheme.titleLight,
                      ),
                    ],
                  ),
                  onPressed: () {
                    _setRecordType(EnumRecordType.income);
                  },
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Expense",
                        style: AppTheme.titleLight,
                      ),
                    ],
                  ),
                  onPressed: () {
                    _setRecordType(EnumRecordType.expense);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get _buttons {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              numberButton("1"),
              numberButton("2"),
              numberButton("3"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              numberButton("4"),
              numberButton("5"),
              numberButton("6"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              numberButton("7"),
              numberButton("8"),
              numberButton("9"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.dashboard),
                onPressed: null,
              ),
              numberButton("0"),
              IconButton(
                icon: Icon(Icons.backspace),
                onPressed: () {
                  _backspaceNumber();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: _recordType == EnumRecordType.income
                    ? AppTheme.primary
                    : AppTheme.warn,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed: () {
                  _navigateToCreateRecord();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget numberButton(String number) {
    return Container(
      height: 60,
      width: 60,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: null,
          child: Text(
            number,
            style: AppTheme.headlineLight,
          ),
          backgroundColor: AppTheme.nearlyWhite,
          onPressed: () => {this._typeNumber(number)},
        ),
      ),
    );
  }

  _typeNumber(number) {
    setState(() {
      final amount = _controller.numberValue * 10;
      final amountLength = amount.toString().split('.')[0].length + 2;
      _controller.updateValue(
          double.parse(amount.toString().substring(0, amountLength) + number));
    });
  }

  _backspaceNumber() {
    setState(() {
      final amount = _controller.numberValue / 10;
      final amountLength = amount.toString().split('.')[0].length + 2;
      _controller.updateValue(
          double.parse((amount).toString().substring(0, amountLength)));
    });
  }

  _navigateToCreateRecord() {
    Application.router.navigateTo(context,
        'record/add/value/${this._controller.numberValue}/type/${this._recordType.index}',
        transition: TransitionType.cupertino);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:reply/styling.dart';
import 'package:reply/transition/expand_transition.dart';

class CreateRecordPage extends StatefulWidget {
  const CreateRecordPage({
    Key key,
    @required this.sourceRect,
  })  : assert(sourceRect != null),
        super(key: key);

  static Route<dynamic> route(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    final Rect sourceRect = box.localToGlobal(Offset.zero) & box.size;

    return PageRouteBuilder<void>(
      pageBuilder: (BuildContext context, _, __) => CreateRecordPage(
        sourceRect: sourceRect,
      ),
      transitionDuration: const Duration(milliseconds: 350),
    );
  }

  @override
  _CreateRecordPageState createState() => _CreateRecordPageState();

  final Rect sourceRect;
}

class _CreateRecordPageState extends State<CreateRecordPage> {
  DateTime selectedDate = DateTime.now();

  MoneyMaskedTextController _controller = new MoneyMaskedTextController(
    leftSymbol: '',
    decimalSeparator: ',',
    thousandSeparator: '.',
    initialValue: 000,
  );

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
    return ExpandItemPageTransition(
      source: widget.sourceRect,
      title: 'Create Record',
      child: Scaffold(
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
      child: Form(
        child: Column(
          children: <Widget>[
            TextFormField(),
            TextFormField(),
            TextFormField(),
          ],
        ),
      ),
    );
  }
}

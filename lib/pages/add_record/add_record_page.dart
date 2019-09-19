import 'package:financial/application.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:financial/create_record_page.dart';
import 'package:financial/model/email_model.dart';
import 'package:financial/styling.dart';
import 'package:financial/transition/fab_fill_transition.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({Key key, @required this.sourceRect})
      : assert(sourceRect != null),
        super(key: key);

  static Route<dynamic> route(BuildContext context, GlobalKey key) {
    final RenderBox box = key.currentContext.findRenderObject();
    final Rect sourceRect = box.localToGlobal(Offset.zero) & box.size;

    return PageRouteBuilder<void>(
      pageBuilder: (BuildContext context, _, __) =>
          AddRecordPage(sourceRect: sourceRect),
      transitionDuration: const Duration(milliseconds: 350),
    );
  }

  final Rect sourceRect;

  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  String _senderEmail = 'from.jennifer@example.com';
  String _subject = '';
  String _recipient = 'Recipient';
  String _recipientAvatar = 'avatar.png';
  MoneyMaskedTextController _controller = new MoneyMaskedTextController(
    leftSymbol: '',
    decimalSeparator: ',',
    thousandSeparator: '.',
    initialValue: 000,
  );

  final GlobalKey _fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final EmailModel emailModel = Provider.of<EmailModel>(context);
    String fabIcon = 'assets/images/ic_edit.png';

    if (emailModel.currentlySelectedEmailId >= 0) {
      // We reply to an email, so let's change the icon during the transition
      fabIcon = 'assets/images/ic_reply.png';
    }

    return FabFillTransition(
      source: widget.sourceRect,
      icon: fabIcon,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primary,
          leading: new Container(),
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(bottom: 20),
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
                    child: _buttons,
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

  Widget get _buttons {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
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
                backgroundColor: AppTheme.primary,
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
    return FloatingActionButton(
      heroTag: null,
      child: Text(
        number,
        style: TextStyle(color: AppTheme.nearlyBlack),
      ),
      backgroundColor: AppTheme.nearlyWhite,
      onPressed: () => {this._typeNumber(number)},
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
    Application.router.navigateTo(
        context, 'record/add/${this._controller.numberValue}',
        transition: TransitionType.cupertino);
  }
}

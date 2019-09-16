import 'package:financial/enum/enum_account_type.dart';
import 'package:financial/styling.dart';
import 'package:flutter/material.dart';

class AddAccountPage extends StatefulWidget {
  final String type;

  AddAccountPage({@required this.type});

  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create account"),
        backgroundColor: AppTheme.primary,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              "Account type",
              style: AppTheme.subtitleBold,
            )
          ],
        ),
      ),
    );
  }
}

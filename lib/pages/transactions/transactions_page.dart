import 'package:financial/styling.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: Text("Transactions"),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:reply/styling.dart';

class AlertWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.subscriptions,
                color: AppTheme.green,
                size: 24,
              ),
              Divider(
                color: Colors.transparent,
                height: 6,
              ),
              Text(
                "You have one thing to resolve",
                style: AppTheme.subtitle,
              ),
              Divider(
                color: Colors.transparent,
                height: 6,
              ),
              ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: AppTheme.green)),
                child: FlatButton(
                  onPressed: () {},
                  color: Colors.white,
                  textColor: AppTheme.green,
                  child: Text(
                    "resolve",
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

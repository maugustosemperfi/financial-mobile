import 'package:flutter/material.dart';
import 'package:reply/styling.dart';

class AlertWidget extends StatelessWidget {
  final IconData iconData;
  final String text;

  AlertWidget({this.iconData, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                iconData,
                color: AppTheme.green,
                size: 24,
              ),
              Divider(
                color: Colors.transparent,
                height: 12,
              ),
              Text(
                text,
                style: AppTheme.title,
                textAlign: TextAlign.center,
              ),
              Divider(
                color: Colors.transparent,
                height: 12,
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

import 'package:financial/styling.dart';
import 'package:flutter/material.dart';

class DixtyScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

import 'package:financial/styling.dart';
import 'package:flutter/material.dart';

class DixtyTextFormFieldWiget extends StatelessWidget {
  final bool readOnly;
  final onTap;
  final Widget suffix;
  final controller;
  final Icon decorationIcon;
  final String hintText;
  final String labelText;
  final TextCapitalization textCapitalization;
  DixtyTextFormFieldWiget({
    this.readOnly = false,
    this.onTap,
    this.suffix,
    this.controller,
    this.decorationIcon,
    this.labelText,
    this.hintText,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.grey)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.grey,
            ),
          ),
          suffix: suffix,
          icon: decorationIcon,
          focusColor: AppTheme.green,
          fillColor: AppTheme.green,
          hoverColor: AppTheme.green,
          hintText: hintText,
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(vertical: 16)),
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      cursorColor: AppTheme.colorStrong,
      textCapitalization: this.textCapitalization,
    );
  }
}

import 'package:financial/styling.dart';
import 'package:flutter/material.dart';

class DixtyTextFormFieldWiget extends StatelessWidget {
  final bool readOnly;
  final onTap;
  final Widget decorationSuffix;
  final controller;
  final Icon decorationIcon;
  final String hintText;
  final String labelText;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final Function validator;
  final bool enabled;
  final Widget prefix;
  DixtyTextFormFieldWiget({
    this.readOnly = false,
    this.onTap,
    this.decorationSuffix,
    this.controller,
    this.decorationIcon,
    this.labelText,
    this.hintText,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.enabled = true,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.whiteGrey)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.whiteGrey,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.whiteGrey,
            ),
          ),
          suffix: decorationSuffix,
          icon: decorationIcon,
          prefix: prefix,
          focusColor: AppTheme.green,
          fillColor: AppTheme.green,
          hoverColor: AppTheme.green,
          hintText: hintText,
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(vertical: 16)),
      readOnly: readOnly,
      enabled: enabled,
      onTap: onTap,
      controller: controller,
      cursorColor: AppTheme.colorStrong,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}

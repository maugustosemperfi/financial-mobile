import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = green;
  static const Color accent = warn;
  static const Color warn = red;
  static const Color colorStrong = purple;
  static const Color textStrong = deepBlue;
  static const Color orange = Color(0xFFFAAB1A);
  static const Color notWhite = Color(0xFFF5F5F5);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFFAAAAAA);
  static const Color darkGrey = Color(0xFF555555);
  static const Color mediumGrey = Color(0xFF888888);
  static const Color whiteGrey = Color(0xFFdfdfdf);
  static const Color green = Color(0xFF08CC6A);
  static const Color red = Color(0xFFFF734C);
  static const Color yellow = Color(0xFFFFD974);
  static const Color purple = Color(0xFF503E9D);
  static const Color deepBlue = Color(0xFF333457);

  static const Color almostInvisible = Color(0xFFDADEE1);
  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);

  static const Color shimmerStart = Color(0xFFF1F2F3);
  static const Color shimmerEnd = Color(0xFFdcdde0);

  @Deprecated("Use darkGrey instead")
  static const Color dark_grey = Color(0xFF888888);

  static const TextTheme textTheme = TextTheme(
    display1: display1,
    headline: headline,
    title: title,
    subtitle: subtitle,
    body2: body2,
    body1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle display2 = TextStyle(
    // h4 -> display1
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    fontSize: 30,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: primary,
  );

  static const TextStyle headlineBlack = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 20,
    letterSpacing: 0.27,
    color: darkGrey,
  );

  static const TextStyle headlineGrey = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 20,
    letterSpacing: 0.27,
    color: mediumGrey,
  );

  static const TextStyle headlineLight = TextStyle(
    // h5 -> headline
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    fontSize: 20,
    letterSpacing: 0.27,
    color: darkText,
  );

  static const TextStyle titleMoneyPositivite = TextStyle(
    // h6 -> title
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: green,
  );

  static const TextStyle titleMoneyNegative = TextStyle(
    // h6 -> title
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: red,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: textStrong,
  );

  static const TextStyle titleLight = TextStyle(
    // h6 -> title
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: nearlyWhite,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: textStrong,
  );

  static const TextStyle subtitleBold = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: textStrong,
  );

  static const TextStyle subtitleLight = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: almostInvisible,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static const TextStyle captionBold = TextStyle(
    // Caption -> caption
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}

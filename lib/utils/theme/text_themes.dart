import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixabay_pagination_example/utils/screen_utils/size_config.dart';

class AppTextThemes {
  late TextStyle _textStyle;

  late TextStyle subtitle1 = _textStyle.copyWith(fontSize: 10.sp(), fontWeight: FontWeight.normal);
  late TextStyle subtitle2 = _textStyle.copyWith(fontSize: 12.sp(), fontWeight: FontWeight.normal);
  late TextStyle bodyText1 = _textStyle.copyWith(fontSize: 14.sp(), fontWeight: FontWeight.normal);
  late TextStyle bodyText2 = _textStyle.copyWith(fontSize: 16.sp(), fontWeight: FontWeight.normal);
  late TextStyle headline1 = _textStyle.copyWith(fontSize: 16.sp(), fontWeight: FontWeight.bold);
  late TextStyle headline2 = _textStyle.copyWith(fontSize: 18.sp(), fontWeight: FontWeight.bold);
  late TextStyle headline3 = _textStyle.copyWith(fontSize: 24.sp(), fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
  late TextStyle headline4 = _textStyle.copyWith(
    decoration: TextDecoration.none,
    fontSize: 40.sp(),
    fontWeight: FontWeight.bold,
  );

  late Color primaryTextColor;

  AppTextThemes({primaryTextColor = Colors.black}) {
    _textStyle = GoogleFonts.cormorant().copyWith(
      color: primaryTextColor,
      decoration: TextDecoration.none,
    );
  }
}
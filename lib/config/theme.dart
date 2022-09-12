import 'package:flutter/material.dart';
import 'package:scanner_app/config/colors.dart';

class DefaultBorder {
  static InputBorder defaultBorder = OutlineInputBorder(
      borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8));

  static InputBorder outlinedBorder = OutlineInputBorder(
      borderSide: BorderSide(width: .8, color: KColors.primaryColor),
      borderRadius: BorderRadius.circular(5));
}

class EnabledBorder {}

// text input theme
class KInputDecorationTheme {
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
      filled: true,
      fillColor: KColors.lightColor.withOpacity(.4),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      enabledBorder: DefaultBorder.defaultBorder,
      focusedBorder: DefaultBorder.defaultBorder,
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red)
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never, labelStyle: TextStyle(fontSize: 14, color: KColors.darkColor, fontWeight: FontWeight.bold)
  );
}

class KTextTheme {
  static TextTheme textTheme = TextTheme(
      headline1: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: KColors.darkColor),
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: KColors.lightColor));
}
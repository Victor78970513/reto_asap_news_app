import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = Colors.grey]) => OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10));

  static final darkThemeMode = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppPalleteColor.scaffoldBackGround,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: _border(),
      focusedBorder: _border(),
    ),
    appBarTheme: const AppBarTheme(
        centerTitle: true, backgroundColor: AppPalleteColor.transparent),
    chipTheme: const ChipThemeData(
        color: MaterialStatePropertyAll(
          AppPalleteColor.scaffoldBackGround,
        ),
        side: BorderSide.none),
  );
}

class AppPalleteColor {
  static const Color scaffoldBackGround = Color(0xff1C2128);
  static const Color gradient1 = Color.fromRGBO(187, 63, 221, 1);
  static const Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
  static const Color gradient3 = Color.fromRGBO(255, 159, 124, 1);
  static const Color transparent = Colors.transparent;
  static const Color grey = Color.fromRGBO(52, 51, 67, 1);
  static const Color chipColor = Color.fromRGBO(24, 24, 32, 1);
}


//TODO: CREATE A PALLETE COLOR

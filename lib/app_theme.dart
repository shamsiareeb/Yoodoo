import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {

  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFE1E1E1),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.white,
      primaryVariant: Colors.white38,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.w300,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w100,
        fontSize: 25.0,
        fontFamily: 'TypoHoop',
      ),
      subtitle1: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.w400
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      title: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      subtitle: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );
}
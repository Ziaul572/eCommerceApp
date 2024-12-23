import 'package:flutter/material.dart';
import 'package:login_test/screens/utils/textTheme.dart';

class TappTheme{
  TappTheme._();

  static ThemeData lightTheme =  ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    //elevatedButtonTheme: ElevatedButtonThemeData()
  );
  static ThemeData darkTheme =  ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darkTextTheme,
  );

}
import 'package:flutter/material.dart';

class SVtheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Gilroy',
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light, seedColor: Colors.blue),
    //scaffoldBackgroundColor: Colors.grey[200],
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Gilroy',
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Colors.blue),
  );
}

//const Color.fromARGB(255, 8, 77, 133)
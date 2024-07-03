import 'package:flutter/material.dart';

class SVtheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Gilroy',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 24),
      titleMedium: TextStyle(fontSize: 20),
      titleSmall: TextStyle(fontSize: 16),
      labelLarge: TextStyle(fontSize: 16),
      labelMedium: TextStyle(fontSize: 14),
      labelSmall: TextStyle(fontSize: 12),
    ),
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light, seedColor: Colors.blue),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Gilroy',
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark, seedColor: Colors.blue),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 24),
      titleMedium: TextStyle(fontSize: 20),
      titleSmall: TextStyle(fontSize: 16),
      labelLarge: TextStyle(fontSize: 16),
      labelMedium: TextStyle(fontSize: 14),
      labelSmall: TextStyle(fontSize: 12),
    ),
  );
}


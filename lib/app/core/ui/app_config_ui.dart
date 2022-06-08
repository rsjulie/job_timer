import 'package:flutter/material.dart';

class AppConfigUI {
  AppConfigUI._();
  static const MaterialColor _primarySwatch = MaterialColor(0xff0066b0, {
    50: Color(0xff005c9e),
    100: Color(0xff00528d),
    200: Color(0xff00477b),
    300: Color(0xff003d6a),
    400: Color(0xff003358),
    500: Color(0xff002946),
    600: Color(0xff001f35),
    700: Color(0xff001423),
    800: Color(0xff000a12),
    900: Color(0xff000000),
  });
  static final ThemeData theme = ThemeData(
      primarySwatch: _primarySwatch,
      primaryColor: const Color(0XFF0066B0),
      primaryColorLight: const Color(0xff219fff),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ));
}

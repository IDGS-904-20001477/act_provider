import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Color(int.parse('0xFFcc0000'));
  static Color secondary = Color(int.parse('0xFF3b4cca'));
  static Color tertiary = Color(int.parse('0xFFffde00'));

  static ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: primary,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(color: secondary, elevation: 0),
      scaffoldBackgroundColor: const Color.fromARGB(255, 245, 224, 243));

  static ThemeData darkTheme = ThemeData.dark().copyWith(
      primaryColor: tertiary,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(color: secondary, elevation: 0),
      scaffoldBackgroundColor: const Color.fromARGB(255, 56, 56, 56));

  static InputDecoration baseInput({required String hintText, required String labelText, IconData? prefixIcon}) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide (color: AppTheme.secondary),
    ),
    focusedBorder: UnderlineInputBorder( 
      borderSide: BorderSide (color: AppTheme.secondary, width: 2),
    ),
    hintText: hintText,
    labelText: labelText,
    labelStyle: const TextStyle(color: Colors.grey), 
    prefixIcon: prefixIcon != null
      ? Icon(prefixIcon, color: AppTheme.tertiary)
      : null,
    );
  }
}

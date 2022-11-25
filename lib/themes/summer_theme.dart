import 'package:flutter/material.dart';
import 'package:people_counter/themes/app_theme.dart';

class SummerTheme implements AppTheme {
  const SummerTheme();

  @override
  ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
      );

  @override
  ThemeData get dark => _base.copyWith(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
      );

  static final _base = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 181, 51, 70),
        textStyle: const TextStyle(fontSize: 32),
        minimumSize: const Size(200, 65),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black87,
        textStyle: const TextStyle(fontSize: 32),
        minimumSize: const Size(200, 65),
      ),
    ),
  );
}

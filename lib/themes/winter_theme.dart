import 'package:flutter/material.dart';

import 'app_theme.dart';

class WinterTheme implements AppTheme {
  const WinterTheme();

  @override
  ThemeData get light => _base.copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.light,
        ),
      );

  @override
  ThemeData get dark => _base.copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
        ),
      );

  static final _base = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        //backgroundColor: Color.fromARGB(255, 181, 51, 70),
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

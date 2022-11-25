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

  static final _base = ThemeData.light().copyWith(
    useMaterial3: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        //backgroundColor: Color.fromARGB(255, 181, 51, 70),
        textStyle: const TextStyle(fontSize: 24),
        minimumSize: const Size(0, 65),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        iconSize: 32, foregroundColor: Colors.white),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStatePropertyAll<Size>(Size(64, 64)),
        iconSize: MaterialStatePropertyAll<double>(24),
      ),
    ),
  );
}

import 'package:people_counter/themes/winter_theme.dart';

class Config {
  // Appearance
  static const theme = WinterTheme();

  static const appTitleLeadIn = 'Tring Together';
  static const appTitle = 'People Counter';

  // Connection (Rails)
  static const apiAddress = 'http://localhost:3000';
  static const httpReloadDelay = Duration(seconds: 3);

  // Counter
  static const counterDebounceDelay = Duration(milliseconds: 1000);

  // Presets
  static const presetEventsList = {'t_christmas_2022'};
}

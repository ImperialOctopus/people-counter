import 'package:flutter/services.dart';

class LowercaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase().replaceAll(' ', ''),
      selection: newValue.selection,
    );
  }
}

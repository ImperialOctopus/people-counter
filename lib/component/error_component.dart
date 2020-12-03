import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  final String message;

  const ErrorComponent({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}

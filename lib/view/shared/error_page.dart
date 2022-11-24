import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String? message;

  const ErrorPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const Icon(Icons.close),
        const Text('An error occurred'),
        if (message != null) Text(message!),
        const Text('Try restarting the app'),
      ]),
    );
  }
}

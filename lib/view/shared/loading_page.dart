import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final String? message;

  const LoadingPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const CircularProgressIndicator(),
        if (message != null) Text(message!),
      ]),
    );
  }
}

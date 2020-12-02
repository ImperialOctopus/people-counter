import 'package:flutter/material.dart';

/// Main app screen with counter.
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Top'),
            Text('Middle'),
            Text('Bottom'),
          ],
        ),
      ),
    );
  }
}

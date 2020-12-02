import 'package:flutter/material.dart';

/// Screen showed while connecting to server.
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Loading...'),
            Text('Middle'),
          ],
        ),
      ),
    );
  }
}

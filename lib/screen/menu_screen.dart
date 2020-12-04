import 'package:flutter/material.dart';

import 'counter_screen.dart';

class MenuScreen extends StatelessWidget {
  static const List<String> _roomNames = [
    'Library Car Park',
    'Brook St. Car Park',
    'Memorial Garden',
    'Church',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Image(
                  width: 600,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/tring_together_logo.png'),
                ),
              ),
            ),
            Text(
              '''Tring Together\nNetworked People Counter''',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _menuButton(context, 0),
                  _menuButton(context, 1),
                  _menuButton(context, 2),
                  _menuButton(context, 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 50,
          minWidth: 200,
        ),
        child: ElevatedButton(
          child: Text(
            _roomNames[index],
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CounterScreen(room: index),
            ),
          ),
        ),
      ),
    );
  }
}

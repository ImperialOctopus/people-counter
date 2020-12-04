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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text(_roomNames[0]),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CounterScreen(room: 0),
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text(_roomNames[1]),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CounterScreen(room: 1),
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text(_roomNames[2]),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CounterScreen(room: 2),
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text(_roomNames[3]),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CounterScreen(room: 3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../service/room/room_service.dart';
import 'counter_screen.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /*
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
            */
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: placeNames
                    .asMap()
                    .entries
                    .map((mapEntry) =>
                        _menuButton(context, mapEntry.value, mapEntry.key))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(BuildContext context, String label, int index) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 50,
          minWidth: 200,
        ),
        child: ElevatedButton(
          child: Text(
            label,
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

import 'package:flutter/material.dart';

import 'events_list/events_list_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Howdy'),
            IconButton(
              icon: const Icon(Icons.play_circle_outline),
              onPressed: () =>
                  Navigator.of(context).push(EventsListScreen.route()),
            )
          ],
        ),
      ),
    );
  }
}

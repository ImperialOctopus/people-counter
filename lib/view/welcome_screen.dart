import 'package:flutter/material.dart';
import 'package:people_counter/config.dart';

import 'events_list/events_list_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Text(
                  title,
                  style: Theme.of(context).textTheme.headline1,
                ),*/
              const SizedBox(
                height: 240,
                child: Center(
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage(Config.headerImage),
                  ),
                ),
              ),
              Text(
                Config.appTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Ink(
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: const CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).push(EventsListScreen.route());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

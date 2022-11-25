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
              //const SizedBox(
              //  height: 240,
              //  child: Center(
              //    child: Image(
              //      fit: BoxFit.contain,
              //      image: AssetImage(Config.headerImage),
              //    ),
              //  ),
              //),
              Text(
                Config.appTitleLeadIn,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                Config.appTitle,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),
              Ink(
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: const CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    size: 32,
                  ),
                  color: Colors.grey.shade100,
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

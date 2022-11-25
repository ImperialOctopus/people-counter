import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_counter/repositories/events/events_repository.dart';

import '../../blocs/counter/counter_cubit.dart';
import '../../transitions/slide_up_transition.dart';

/// Main app screen with counter.
class CounterScreen extends StatelessWidget {
  final LocationConnection locationConnection;
  final String eventName;

  /// Main app screen with counter.
  const CounterScreen({
    super.key,
    required this.locationConnection,
    required this.eventName,
  });

  static Route<void> route(
      LocationConnection locationConnection, String eventName) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CounterScreen(
        locationConnection: locationConnection,
        eventName: eventName,
      ),
      transitionsBuilder: slideUpTransition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Reset Counter"),
                content: const Text(
                    // ignore: lines_longer_than_80_chars
                    "This will reset the counter for this location to zero.\nHas Steffi said you're allowed to do this?"),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  TextButton(
                    child: const Text("Reset Counter"),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            ).then((value) {
              if (value == true) {
                context.read<CounterCubit>().recordReset();
              }
            }),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              eventName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              locationConnection.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24),
            IconButton(
              iconSize: 48,
              icon: const Icon(Icons.arrow_upward),
              onPressed: () => context.read<CounterCubit>().recordEntry(),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                context.watch<CounterCubit>().state.toString(),
                style: const TextStyle(fontSize: 36),
              ),
            ),
            IconButton(
              iconSize: 48,
              icon: const Icon(Icons.arrow_downward),
              onPressed: () => context.read<CounterCubit>().recordExit(),
            ),
          ],
        ),
      ),
    );
  }
}

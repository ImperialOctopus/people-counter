import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter/counter_bloc.dart';
import '../bloc/counter/counter_event.dart';
import '../bloc/counter/counter_state.dart';

/// Main app screen with counter.
class CounterScreen extends StatelessWidget {
  final String title;
  final int index;

  /// Main app screen with counter.
  const CounterScreen({required this.title, required this.index, Key? key})
      : super(key: key);

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
                    "This will reset the counter to zero.\nAre you sure?"),
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
                BlocProvider.of<CounterBloc>(context)
                    .add(ResetCounterEvent(index));
              }
            }),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
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
            */
            const Padding(padding: EdgeInsets.symmetric(vertical: 12)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 48,
                    icon: const Icon(Icons.arrow_upward),
                    onPressed: () => BlocProvider.of<CounterBloc>(context)
                        .add(IncrementCounterEvent(index)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: BlocBuilder<CounterBloc, CounterState>(
                      builder: (context, state) {
                        if (state is LoadingCounterState) {
                          return const CircularProgressIndicator();
                        }
                        if (state is LiveCounterState) {
                          return Text(
                            state.value[index].toString(),
                            style: const TextStyle(fontSize: 36),
                          );
                        }
                        throw FallThroughError();
                      },
                    ),
                  ),
                  IconButton(
                    iconSize: 48,
                    icon: const Icon(Icons.arrow_downward),
                    onPressed: () => BlocProvider.of<CounterBloc>(context)
                        .add(DecrementCounterEvent(index)),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter/counter_bloc.dart';
import '../bloc/counter/counter_event.dart';

/// Main app screen with counter.
class CounterScreen extends StatelessWidget {
  /// Value currently in counter.
  final int value;

  /// Main app screen with counter.
  const CounterScreen({@required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Up'),
              onPressed: () => BlocProvider.of<CounterBloc>(context)
                  .add(ModifyCounterEvent(1)),
            ),
            Text(value.toString()),
            RaisedButton(
              child: Text('Down'),
              onPressed: () => BlocProvider.of<CounterBloc>(context)
                  .add(ModifyCounterEvent(-1)),
            ),
          ],
        ),
      ),
    );
  }
}

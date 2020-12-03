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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 48,
                    icon: Icon(Icons.arrow_upward),
                    onPressed: () => BlocProvider.of<CounterBloc>(context)
                        .add(ModifyCounterEvent(1)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                  ),
                  value == null
                      ? CircularProgressIndicator()
                      : Text(
                          value.toString(),
                          style: TextStyle(fontSize: 36),
                        ),
                  Padding(
                    padding: EdgeInsets.all(24),
                  ),
                  IconButton(
                    iconSize: 48,
                    icon: Icon(Icons.arrow_downward),
                    onPressed: () => BlocProvider.of<CounterBloc>(context)
                        .add(ModifyCounterEvent(-1)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

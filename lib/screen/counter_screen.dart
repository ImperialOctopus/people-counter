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
        child: FractionallySizedBox(
          heightFactor: 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              Column(
                mainAxisSize: MainAxisSize.min,
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
                    child: value == null
                        ? CircularProgressIndicator()
                        : Text(
                            value.toString(),
                            style: TextStyle(fontSize: 36),
                          ),
                  ),
                  IconButton(
                    iconSize: 48,
                    icon: Icon(Icons.arrow_downward),
                    onPressed: () => BlocProvider.of<CounterBloc>(context)
                        .add(ModifyCounterEvent(-1)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

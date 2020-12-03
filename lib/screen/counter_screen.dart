import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter/counter_bloc.dart';
import '../bloc/counter/counter_event.dart';

/// Main app screen with counter.
class CounterScreen extends StatelessWidget {
  final int room;

  static const List<String> _roomNames = [
    'Library Car Park',
    'Brook St. Car Park',
    'Memorial Garden',
    'Church',
  ];

  /// Main app screen with counter.
  const CounterScreen({@required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text(
              _roomNames[room],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 48,
                    icon: Icon(Icons.arrow_upward),
                    onPressed: () => BlocProvider.of<CounterBloc>(context)
                        .add(ModifyCounterEvent(room, 1)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: BlocBuilder<CounterBloc, Map<int, int>>(
                      builder: (context, state) {
                        return state[room] == null
                            ? CircularProgressIndicator()
                            : Text(
                                state.toString(),
                                style: TextStyle(fontSize: 36),
                              );
                      },
                    ),
                  ),
                  IconButton(
                    iconSize: 48,
                    icon: Icon(Icons.arrow_downward),
                    onPressed: () => BlocProvider.of<CounterBloc>(context)
                        .add(ModifyCounterEvent(room, -1)),
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

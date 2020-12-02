import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter/counter_bloc.dart';

/// Main app screen with counter.
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Up'),
              onPressed: () => BlocProvider.of<CounterBloc>(context),
            ),
            Text('Middle'),
            Text('Bottom'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter/counter_bloc.dart';
import '../bloc/counter/counter_state.dart';
import 'counter_screen.dart';
import 'splash_screen.dart';

/// Screen containing the other screens.
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, state) {
        if (state is CounterStateUninitialised) {
          return SplashScreen();
        }
        if (state is CounterStateLoaded) {
          return CounterScreen(value: state.value);
        }
        throw FallThroughError();
      },
    );
  }
}

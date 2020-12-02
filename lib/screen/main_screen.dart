import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter/counter_bloc.dart';
import 'counter_screen.dart';

/// Screen containing the other screens.
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, state) {
        return CounterScreen(value: state);
      },
    );
  }
}

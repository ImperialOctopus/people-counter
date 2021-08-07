import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter/counter_bloc.dart';
import '../bloc/room/room_state.dart';
import '../bloc/stats/stats_bloc.dart';
import 'counter_location_select.dart';

class CounterNavigator extends StatelessWidget {
  final InRoom state;

  const CounterNavigator({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
            create: (context) =>
                CounterBloc(roomConnection: state.roomConnection)),
        BlocProvider<StatsBloc>(
            create: (context) =>
                StatsBloc(roomConnection: state.roomConnection)),
      ],
      child: Navigator(
        pages: [
          MaterialPage(
            child: CounterLocationSelect(roomState: state),
          ),
        ],
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }
}

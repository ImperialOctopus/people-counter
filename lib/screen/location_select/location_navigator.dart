import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/counter/counter_bloc.dart';
import '../../bloc/room/room_state.dart';
import 'location_select.dart';

class LocationNavigator extends StatelessWidget {
  final RoomStateIn state;

  const LocationNavigator({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
            create: (context) =>
                CounterBloc(roomConnection: state.roomConnection)),
      ],
      child: Navigator(
        pages: [
          MaterialPage(
            child: LocationSelect(roomState: state),
          ),
        ],
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }
}

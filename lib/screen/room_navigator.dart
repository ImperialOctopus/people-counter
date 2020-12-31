import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_counter/screen/preset_room_screen.dart';

import '../bloc/room/room_bloc.dart';
import '../bloc/room/room_state.dart';
import 'counter_navigator.dart';
import 'room_select_screen.dart';

class RoomNavigator extends StatelessWidget {
  final Widget roomSelect;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const RoomNavigator({@required this.roomSelect});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomBloc, RoomState>(
      listener: _onRoomBlocChanged,
      child: Navigator(
        key: navigatorKey,
        pages: [
          MaterialPage(
            child: roomSelect,
          ),
        ],
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }

  void _onRoomBlocChanged(BuildContext context, RoomState state) {
    if (state is InRoom) {
      navigatorKey.currentState.push(
        MaterialPageRoute(
          builder: (context) => CounterNavigator(state: state),
        ),
      );
    }
    if (state is OutRoom) {
      navigatorKey.currentState.pop();
    }
  }
}

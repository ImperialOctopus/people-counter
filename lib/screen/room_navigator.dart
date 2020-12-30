import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/room/room_bloc.dart';
import '../bloc/room/room_state.dart';
import 'room_screen.dart';
import 'room_select_screen.dart';

class RoomNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomBloc, RoomState>(
      listener: _onRoomBlocChanged,
      child: Navigator(
        key: navigatorKey,
        pages: [
          MaterialPage(
            child: RoomSelectScreen(),
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
          builder: (context) => RoomScreen(),
        ),
      );
    }
  }
}

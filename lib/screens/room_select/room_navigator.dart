import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/room/room_bloc.dart';
import '../../blocs/room/room_state.dart';
import '../location_select/location_navigator.dart';

class RoomNavigator extends StatelessWidget {
  final Widget roomSelect;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const RoomNavigator({required this.roomSelect, Key? key}) : super(key: key);

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
    if (state is RoomStateIn) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => LocationNavigator(state: state),
        ),
      );
    }
    if (state is RoomStateNone) {
      navigatorKey.currentState?.pop();
    }
  }
}

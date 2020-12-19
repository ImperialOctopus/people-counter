import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/room/room_bloc.dart';
import '../bloc/room/room_event.dart';
import '../bloc/room/room_state.dart';
import 'room_screen.dart';

class RoomSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RoomBloc, RoomState>(
          listener: _onRoomBlocChanged,
          builder: (context, state) {
            if (state is LoadingRoom) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is OutRoom) {
              return Column(
                children: [
                  ElevatedButton(
                    child: Text('AA34'),
                    onPressed: () {
                      BlocProvider.of<RoomBloc>(context)
                          .add(EnterRoomEvent('test_room'));
                    },
                  ),
                ],
              );
            }
            return Center(child: Text('Error loading bloc. Please restart.'));
          }),
    );
  }

  void _onRoomBlocChanged(BuildContext context, RoomState state) {
    if (state is InRoom) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RoomScreen(),
        ),
      );
    }
  }
}

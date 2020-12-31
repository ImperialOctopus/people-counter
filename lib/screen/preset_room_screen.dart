import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/room/room_bloc.dart';
import '../bloc/room/room_event.dart';
import '../bloc/room/room_state.dart';

class PresetRoomScreen extends StatelessWidget {
  final String title;
  final String roomName;

  const PresetRoomScreen({@required this.title, @required this.roomName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: BlocBuilder<RoomBloc, RoomState>(
            builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Container(height: 20),
                (state is LoadingRoom || state is InRoom)
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        child: Text('Join Event'),
                        onPressed: () {
                          BlocProvider.of<RoomBloc>(context)
                              .add(EnterRoomEvent(roomName));
                        },
                      ),
                if (state is RoomLoadError) Container(height: 20),
                if (state is RoomLoadError)
                  Text(
                    'failed to load - please try again',
                    style: Theme.of(context).textTheme.headline6,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

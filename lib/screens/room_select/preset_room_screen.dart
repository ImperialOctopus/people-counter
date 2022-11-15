import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/room/room_bloc.dart';
import '../../blocs/room/room_event.dart';
import '../../blocs/room/room_state.dart';
import '../../config.dart' as config;

class PresetRoomScreen extends StatelessWidget {
  final String title;
  final String roomName;

  const PresetRoomScreen(
      {required this.title, required this.roomName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: BlocBuilder<RoomBloc, RoomState>(
            builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*Text(
                  title,
                  style: Theme.of(context).textTheme.headline1,
                ),*/
                const SizedBox(
                  height: 240,
                  child: Center(
                    child: Image(
                      fit: BoxFit.contain,
                      image: AssetImage(config.headerLocation),
                    ),
                  ),
                ),
                /*Text(
                  'People Counter',
                  style: Theme.of(context).textTheme.headline4,
                ),*/
                const SizedBox(height: 20),
                (state is RoomStateLoading || state is RoomStateIn)
                    ? const CircularProgressIndicator()
                    : Ink(
                        decoration: ShapeDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: const CircleBorder(),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          color: Colors.white,
                          iconSize: 32,
                          onPressed: () {
                            BlocProvider.of<RoomBloc>(context)
                                .add(EnterRoomEvent(roomName));
                          },
                        ),
                      ),
                if (state is RoomStateError) ...[
                  const SizedBox(height: 20),
                  Text(
                    'failed to load - please try again',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

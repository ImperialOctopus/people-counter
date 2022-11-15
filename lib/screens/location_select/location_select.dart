import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/room/room_bloc.dart';
import '../../blocs/room/room_event.dart';
import '../../blocs/room/room_state.dart';
import 'counter_screen.dart';

class LocationSelect extends StatelessWidget {
  final RoomStateIn roomState;

  const LocationSelect({required this.roomState, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              BlocProvider.of<RoomBloc>(context).add(const LeaveRoomEvent()),
        ),
        //title: Text(roomState.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    roomState.roomInfo.title,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text(
                    'Location',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 24),
                  ...roomState.roomInfo.locations.asMap().entries.map(
                      (mapEntry) => _locationButton(
                          context, mapEntry.value, mapEntry.key)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationButton(BuildContext context, String title, int index) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        child: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CounterScreen(
                roomTitle: roomState.roomInfo.title,
                title: title,
                index: index),
          ),
        ),
      ),
    );
  }
}
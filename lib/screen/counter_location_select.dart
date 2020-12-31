import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/room/room_bloc.dart';
import '../bloc/room/room_event.dart';
import '../bloc/room/room_state.dart';
import 'counter_screen.dart';
import 'stats_screen.dart';

class CounterLocationSelect extends StatelessWidget {
  final InRoom roomState;

  const CounterLocationSelect({@required this.roomState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              BlocProvider.of<RoomBloc>(context).add(const LeaveRoomEvent()),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /*
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Image(
                  width: 600,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/tring_together_logo.png'),
                ),
              ),
            ),
            Text(
              '''Tring Together\nNetworked People Counter''',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            */
            Text(
              roomState.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...roomState.placeNames.asMap().entries.map((mapEntry) =>
                      _locationButton(context, mapEntry.value, mapEntry.key)),
                  _statsButton(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationButton(BuildContext context, String label, int index) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        child: Text(
          label,
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CounterScreen(title: label, index: index),
          ),
        ),
      ),
    );
  }

  Widget _statsButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: OutlinedButton(
        child: Text(
          'Stats',
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StatsScreen(title: roomState.name),
          ),
        ),
      ),
    );
  }
}

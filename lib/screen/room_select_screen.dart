import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/database/database_service.dart';
import 'room_screen.dart';

class RoomSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: Text('AA34'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RoomScreen(
                  roomService: RepositoryProvider.of<DatabaseService>(context)
                      .getRoom('AA34'),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

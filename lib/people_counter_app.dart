import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/room_select/preset_room_screen.dart';
import 'screens/room_select/room_navigator.dart';
import 'screens/room_select/room_select_screen.dart';
import 'services/database/database_service.dart';
import 'services/database/firebase_database_service.dart';
import 'themes/theme.dart';

/// Full app widget.
class PeopleCounterApp extends StatefulWidget {
  const PeopleCounterApp({super.key});

  @override
  State<PeopleCounterApp> createState() => _PeopleCounterAppState();
}

class _PeopleCounterAppState extends State<PeopleCounterApp> {
  late final DatabaseService _databaseService;

  @override
  void initState() {
    super.initState();

    _databaseService = FirebaseDatabaseService();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appTitle,
      theme: themeData,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<DatabaseService>.value(value: _databaseService),
        ],
        child: MultiBlocProvider(
            providers: [],
            child: Navigator(
              pages: const [
                MaterialPage(
                  child: RoomNavigator(
                    roomSelect: config.allowCustomRoomCode
                        ? RoomSelectScreen(title: config.appTitle)
                        : PresetRoomScreen(
                            title: config.appTitle, roomName: config.roomCode),
                  ),
                ),
              ],
              onPopPage: (route, result) => route.didPop(result),
            )),
      ),
    );
  }
}

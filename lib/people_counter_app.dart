import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/room/room_bloc.dart';
import 'config.dart' as config;
import 'screens/room_select/preset_room_screen.dart';
import 'screens/room_select/room_navigator.dart';
import 'screens/room_select/room_select_screen.dart';
import 'services/database/database_service.dart';
import 'services/database/firebase_database_service.dart';
import 'themes/theme.dart';

/// Full app widget.
class PeopleCounterApp extends StatefulWidget {
  const PeopleCounterApp({Key? key}) : super(key: key);

  @override
  _PeopleCounterAppState createState() => _PeopleCounterAppState();
}

class _PeopleCounterAppState extends State<PeopleCounterApp> {
  late final Future<FirebaseApp> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: config.appTitle,
      theme: themeData,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                  // ignore: lines_longer_than_80_chars
                  'We had a problem connecting to the internet.\nPlease try restarting this app.'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return const AppView();
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

/// Stateful app view.
class AppView extends StatefulWidget {
  /// Stateful app view.
  const AppView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final RoomBloc _roomBloc;

  late final DatabaseService _databaseService;

  @override
  void initState() {
    super.initState();

    _databaseService = FirebaseDatabaseService();

    _roomBloc = RoomBloc(_databaseService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DatabaseService>.value(value: _databaseService),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<RoomBloc>.value(value: _roomBloc),
          ],
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
    );
  }
}

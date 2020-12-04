import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter/counter_bloc.dart';
import 'screen/menu_screen.dart';
import 'service/database/database_service.dart';
import 'service/database/firebase_database_service.dart';
import 'theme/theme.dart';

/// Full app widget.
class PeopleCounterApp extends StatefulWidget {
  @override
  _PeopleCounterAppState createState() => _PeopleCounterAppState();
}

class _PeopleCounterAppState extends State<PeopleCounterApp> {
  Future<FirebaseApp> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tring Together People Counter',
      theme: themeData,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  // ignore: lines_longer_than_80_chars
                  'We had a problem connecting to the internet.\nPlease try restarting this app.'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return AppView();
          }

          return Center(
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
  const AppView();

  @override
  State<StatefulWidget> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  DatabaseService _databaseService;
  CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();

    _databaseService = FirebaseDatabaseService();

    _counterBloc = CounterBloc(databaseService: _databaseService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DatabaseService>.value(value: _databaseService),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<CounterBloc>.value(value: _counterBloc),
          ],
          child: Navigator(
            pages: [
              MaterialPage(
                child: MenuScreen(),
              ),
            ],
            onPopPage: (route, result) => route.didPop(result),
          )),
    );
  }
}

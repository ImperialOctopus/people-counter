import 'package:ansible_counter/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter/counter_bloc.dart';
import 'screen/error_screen.dart';
import 'screen/main_screen.dart';
import 'service/database/database_service.dart';
import 'service/database/test_database_service.dart';
import 'theme/theme.dart';

/// Full app widget.
class AnsibleCounterApp extends StatelessWidget {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return const AppView();
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
  Future<FirebaseApp> _initialization;

  DatabaseService _databaseService;
  CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();

    _initialization = Firebase.initializeApp();

    _databaseService = TestDatabaseService();
    _counterBloc = CounterBloc(databaseService: _databaseService);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ansible Counter',
      theme: themeData,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return ErrorScreen(
                message: '''We had a problem connecting to the internet.
          Please try restarting this app.''');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiRepositoryProvider(
              providers: [
                RepositoryProvider<DatabaseService>.value(
                    value: _databaseService),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<CounterBloc>.value(value: _counterBloc),
                ],
                child: MainScreen(),
              ),
            );
          }

          return SplashScreen();
        },
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter/counter_bloc.dart';
import 'screen/error_screen.dart';
import 'screen/main_screen.dart';
import 'screen/splash_screen.dart';
import 'service/database/database_service.dart';
import 'service/database/firebase_database_service.dart';
import 'theme/theme.dart';

/// Full app widget.
class AnsibleCounterApp extends StatefulWidget {
  @override
  _AnsibleCounterAppState createState() => _AnsibleCounterAppState();
}

class _AnsibleCounterAppState extends State<AnsibleCounterApp> {
  Future<FirebaseApp> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = Firebase.initializeApp();
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
            return AppView();
          }

          return SplashScreen();
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
        child: MainScreen(),
      ),
    );
  }
}

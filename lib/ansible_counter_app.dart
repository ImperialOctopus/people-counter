import 'package:ansible_counter/component/error_component.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter/counter_bloc.dart';
import 'screen/main_screen.dart';
import 'service/database/database_service.dart';
import 'service/database/test_database_service.dart';
import 'theme/theme.dart';

/// Full app widget.
class AnsibleCounterApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return ErrorComponent(message: snapshot.error);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return const AppView();
        }

        return CircularProgressIndicator();
      },
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

    _databaseService = TestDatabaseService();
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
        child: MaterialApp(
          title: 'Ansible Counter',
          theme: themeData,
          home: MainScreen(),
        ),
      ),
    );
  }
}

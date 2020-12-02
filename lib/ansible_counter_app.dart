import 'package:ansible_counter/bloc/counter/counter_bloc.dart';
import 'package:ansible_counter/service/database/database_service.dart';
import 'package:ansible_counter/service/database/test_database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screen/main_screen.dart';
import 'theme/theme.dart';

/// Full app widget.
class AnsibleCounterApp extends StatelessWidget {
  /// Full app widget.
  const AnsibleCounterApp();

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

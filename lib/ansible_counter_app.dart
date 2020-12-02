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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [],
      child: MultiBlocProvider(
        providers: [],
        child: MaterialApp(
          title: 'Ansible Counter',
          theme: themeData,
          home: MainScreen(),
        ),
      ),
    );
  }
}

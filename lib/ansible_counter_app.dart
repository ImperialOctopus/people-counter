import 'package:ansible_counter/screen/main_screen.dart';
import 'package:ansible_counter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnsibleCounterApp extends StatelessWidget {
  const AnsibleCounterApp();

  @override
  Widget build(BuildContext context) {
    return const AppView();
  }
}

class AppView extends StatefulWidget {
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

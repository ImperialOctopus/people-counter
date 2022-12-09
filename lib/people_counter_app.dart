import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config.dart';
import 'repositories/events/events_repository.dart';
import 'repositories/events/rails_events_repository.dart';
import 'repositories/saved_codes/saved_codes_repository.dart';
import 'repositories/saved_codes/shared_preferences_saved_codes_repository.dart';
import 'view/welcome_screen.dart';

/// Full app widget.
class PeopleCounterApp extends StatefulWidget {
  const PeopleCounterApp({super.key});

  @override
  State<PeopleCounterApp> createState() => _PeopleCounterAppState();
}

class _PeopleCounterAppState extends State<PeopleCounterApp> {
  late final EventsRepository eventsRepository;
  late final SavedCodesRepository savedCodesRepository;

  @override
  void initState() {
    super.initState();

    eventsRepository =
        const RailsEventsRepository(apiAddress: Config.apiAddress);
    savedCodesRepository = SharedPreferencesSavedCodesRepository();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EventsRepository>.value(value: eventsRepository),
        RepositoryProvider<SavedCodesRepository>.value(
            value: savedCodesRepository)
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.appTitle,
      theme: Config.theme.light,
      //darkTheme: Config.theme.dark,
      home: const WelcomeScreen(),
    );
  }
}

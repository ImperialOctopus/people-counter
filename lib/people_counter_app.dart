import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_counter/config.dart';
import 'package:people_counter/repositories/saved_codes/shared_preferences_saved_codes_repository.dart';

import 'repositories/events/events_repository.dart';
import 'repositories/events/firebase_event_repository.dart';
import 'repositories/saved_codes/saved_codes_repository.dart';
import 'view/shared/error_page.dart';
import 'view/shared/loading_page.dart';
import 'view/welcome_screen.dart';

/// Full app widget.
class PeopleCounterApp extends StatefulWidget {
  const PeopleCounterApp({super.key});

  @override
  State<PeopleCounterApp> createState() => _PeopleCounterAppState();
}

class _PeopleCounterAppState extends State<PeopleCounterApp> {
  late final Future<EventsRepository> eventsRepository;
  late final SavedCodesRepository savedCodesRepository;

  @override
  void initState() {
    super.initState();

    eventsRepository = FirebaseEventsRepository.initialise();
    savedCodesRepository = SharedPreferencesSavedCodesRepository();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: eventsRepository,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MultiRepositoryProvider(
              providers: [
                RepositoryProvider<EventsRepository>.value(
                    value: snapshot.data!),
                RepositoryProvider<SavedCodesRepository>.value(
                    value: savedCodesRepository)
              ],
              child: const AppView(),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: ErrorPage(
                    message:
                        'Error loading database connection. Check your internet connection and try again. Further information: ${snapshot.error}'),
              ),
            );
          } else {
            return const MaterialApp(
              home: Scaffold(
                body: LoadingPage(message: 'Loading database connector...'),
              ),
            );
          }
        });
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

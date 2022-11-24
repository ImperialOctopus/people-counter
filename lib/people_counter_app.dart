import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/events/events_repository.dart';
import 'repositories/events/firebase_event_repository.dart';
import 'themes/people_counter_theme.dart';
import 'view/shared/error_page.dart';
import 'view/shared/loading_page.dart';
import 'view/welcome_screen.dart';

/// Full app widget.
class PeopleCounterApp extends StatefulWidget {
  static const title = 'People Counter';

  const PeopleCounterApp({super.key});

  @override
  State<PeopleCounterApp> createState() => _PeopleCounterAppState();
}

class _PeopleCounterAppState extends State<PeopleCounterApp> {
  late final Future<EventsRepository> _eventsRepository;

  @override
  void initState() {
    super.initState();

    _eventsRepository = FirebaseEventsRepository.initialise();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: PeopleCounterApp.title,
      theme: PeopleCounterTheme.light,
      darkTheme: PeopleCounterTheme.dark,
      home: FutureBuilder(
          future: _eventsRepository,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MultiRepositoryProvider(
                providers: [
                  RepositoryProvider<EventsRepository>.value(
                      value: snapshot.data!),
                ],
                child: const WelcomeScreen(),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                body: ErrorPage(
                    message:
                        'Error loading database connection. Check your internet connection and try again. Further information: ${snapshot.error}'),
              );
            } else {
              return const Scaffold(
                body: LoadingPage(message: 'Loading database connector...'),
              );
            }
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:people_counter/repositories/events/events_repository.dart';
import 'package:people_counter/transitions/slide_up_transition.dart';
import 'package:people_counter/view/event/location_list.dart';
import 'package:people_counter/view/shared/error_page.dart';
import 'package:people_counter/view/shared/loading_page.dart';

class EventScreen extends StatefulWidget {
  final EventConnection eventConnection;

  const EventScreen({super.key, required this.eventConnection});

  static Route<void> route({required EventConnection eventConnection}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EventScreen(
        eventConnection: eventConnection,
      ),
      transitionsBuilder: slideUpTransition,
    );
  }

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late final Future<List<Future<LocationConnection>>> locations;

  @override
  void initState() {
    locations = widget.eventConnection.locations;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        //title: Text(roomState.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.eventConnection.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Location',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: FutureBuilder(
                    future: locations,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return LocationList(
                          locationConnections: snapshot.data!,
                          roomName: widget.eventConnection.name,
                        );
                      } else if (snapshot.hasError) {
                        return ErrorPage(
                            message:
                                'Error loading ${widget.eventConnection.name}: ${snapshot.error}');
                      } else {
                        return LoadingPage(
                            message: 'Loading ${widget.eventConnection.name}');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

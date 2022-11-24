import 'package:flutter/material.dart';
import 'package:people_counter/repositories/events/events_repository.dart';

import '../counter/counter_screen.dart';

class LocationListItem extends StatefulWidget {
  final Future<LocationConnection> locationConnection;

  const LocationListItem({super.key, required this.locationConnection});

  @override
  State<LocationListItem> createState() => _LocationListItemState();
}

class _LocationListItemState extends State<LocationListItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.locationConnection,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListTile(
            title: Text(snapshot.data!.name),
            onTap: () =>
                Navigator.of(context).push(CounterScreen.route(snapshot.data!)),
          );
        } else if (snapshot.hasError) {
          return ListTile(
            leading: Icon(Icons.error_outline, color: Colors.red.shade400),
          );
        } else {
          return const ListTile(leading: CircularProgressIndicator());
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:people_counter/repositories/events/events_repository.dart';

import '../components/list_card.dart';
import '../counter/counter_screen.dart';

class LocationListItem extends StatefulWidget {
  final Future<LocationConnection> locationConnection;
  final String roomName;

  const LocationListItem({
    super.key,
    required this.locationConnection,
    required this.roomName,
  });

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
          return ListCard(
            title: Text(snapshot.data!.name),
            onTap: () => Navigator.of(context).push(CounterScreen.route(
              snapshot.data!,
              widget.roomName,
            )),
          );
        } else if (snapshot.hasError) {
          return ListCard(
            leading: Icon(Icons.error_outline, color: Colors.red.shade400),
          );
        } else {
          return const ListCard(leading: CircularProgressIndicator());
        }
      },
    );
  }
}

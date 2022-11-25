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
          final locationConnection = snapshot.data!;
          return ListCard(
            title: Text(locationConnection.name),
            onTap: () => Navigator.of(context).push(CounterScreen.route(
              locationConnection,
              widget.roomName,
            )),
            trailing: StreamBuilder(
              stream: locationConnection.valuesStream,
              initialData: locationConnection.current,
              builder: (context, valueSnapshot) {
                if (valueSnapshot.data == null) {
                  return const CircularProgressIndicator();
                } else {
                  return Text(
                    valueSnapshot.data.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  );
                }
              },
            ),
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

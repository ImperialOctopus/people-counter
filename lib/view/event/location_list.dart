import 'package:flutter/material.dart';
import 'package:people_counter/repositories/events/events_repository.dart';
import 'package:people_counter/view/event/location_list_item.dart';

class LocationList extends StatelessWidget {
  final List<Future<LocationConnection>> locationConnections;
  final String roomName;

  const LocationList({
    super.key,
    required this.locationConnections,
    required this.roomName,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: locationConnections.length,
      itemBuilder: (context, index) => LocationListItem(
        locationConnection: locationConnections[index],
        roomName: roomName,
      ),
    );
  }
}

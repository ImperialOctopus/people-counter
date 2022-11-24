import 'package:flutter/material.dart';
import 'package:people_counter/repositories/events/events_repository.dart';
import 'package:people_counter/view/event/location_list_item.dart';

class LocationList extends StatelessWidget {
  final List<Future<LocationConnection>> locationConnections;

  const LocationList({super.key, required this.locationConnections});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        itemCount: locationConnections.length,
        separatorBuilder: (context, _) => const Divider(),
        itemBuilder: (context, index) =>
            LocationListItem(locationConnection: locationConnections[index]),
      ),
    );
  }
}

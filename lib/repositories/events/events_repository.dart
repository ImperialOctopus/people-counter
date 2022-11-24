import 'dart:async';

abstract class EventsRepository {
  Future<EventConnection> getEventByCode(String code);
}

abstract class EventConnection {
  String get code;
  String get name;
  Future<List<Future<LocationConnection>>> get locations;
}

abstract class LocationConnection {
  Future<void> sendIncrement();
  Future<void> sendDecrement();
  Future<void> sendReset();

  String get name;
  Stream<int> get valuesStream;
}

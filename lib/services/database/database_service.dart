import 'dart:async';

abstract class DatabaseService {
  Future<void> initialise();
  Future<EventConnection> getEventByCode(String code);
}

abstract class EventConnection {
  String get code;
  Future<String> get name;
  Future<List<LocationConnection>> get locations;
}

abstract class LocationConnection {
  Future<void> sendIncrement();
  Future<void> sendDecrement();
  Future<void> sendReset();

  Future<String> get name;
  Stream<int> get valuesStream;
}

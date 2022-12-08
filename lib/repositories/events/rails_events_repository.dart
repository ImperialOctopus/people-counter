import 'events_repository.dart';

class RailsEventsRepository implements EventsRepository {
  final String apiEndpoint;

  const RailsEventsRepository({required this.apiEndpoint});

  @override
  Future<EventConnection?> getEventByCode(String code) =>
      RailsEventConnection.initialise(code);
}

class RailsEventConnection implements EventConnection {
  @override
  final String code;
  @override
  final String name;

  const RailsEventConnection._(this.code, this.name);

  static Future<RailsEventConnection?> initialise(String code) async {}

  @override
  Future<List<Future<LocationConnection>>> get locations async => [];
}

class RailsLocationConnection implements LocationConnection {
  const RailsLocationConnection._();

  static Future<RailsLocationConnection> _initialise()
  
  Future<void> sendIncrement();
  Future<void> sendDecrement();
  Future<void> sendReset();

  String get name;
  int get current;
  Stream<int> get valuesStream;
}

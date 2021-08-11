import 'package:people_counter/model/stats_snapshot.dart';

/// Interface for database service.
abstract class RoomConnection {
  // Modify stored value. May use transactions for safety.
  Future<void> incrementLocation(int index);
  Future<void> decrementLocation(int index);
  Future<void> resetLocation(int index);
  Future<void> resetAllLocations();

  // Gets stored values from the database.
  Future<String> get title;
  Future<List<String>> get locations;

  Stream<List<int>> get valuesStream;

  // Stats
  Future<StatsSnapshot> get stats;
}

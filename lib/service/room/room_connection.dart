import '../../model/stats_snapshot.dart';

/// Interface for database service.
abstract class RoomConnection {
  /// Modify stored value. May use transactions for safety.
  Future<void> incrementLocation(int index);
  Future<void> decrementLocation(int index);

  Future<void> resetLocation(int index);

  Future<void> resetStats();

  /// Gets stored value from the database.
  Stream<List<int>> get valuesStream;

  /// Stream of total people entered from stats
  Stream<StatsSnapshot> get statsStream;

  Future<List<String>> get locations;

  Future<String> get title;
}

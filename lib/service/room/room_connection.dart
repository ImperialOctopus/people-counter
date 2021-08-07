import '../../model/log_entry.dart';

/// Interface for database service.
abstract class RoomConnection {
  // Modify stored value. May use transactions for safety.
  Future<void> incrementLocation(int index);
  Future<void> decrementLocation(int index);
  Future<void> resetLocation(int index);

  // Gets stored values from the database.
  Future<String> get title;
  Future<List<String>> get locations;

  Stream<List<int>> get valuesStream;

  // Stats
  Future<List<LogEntry>> get stats;
  Future<void> resetStats();

  Future<void> resetAll();
}

import '../../model/stats_snapshot.dart';

/// Interface for database service.
abstract class RoomService {
  /// Modify stored value. May use transactions for safety.
  Future<void> incrementLocation(int index);
  Future<void> decrementLocation(int index);

  Future<void> resetLocation(int index);

  /// Gets stored value from the database.
  Stream<List<int>> get valueStream;

  /// Stream of total people entered from stats
  Stream<StatsSnapshot> get statsStream;

  Future<void> resetStats();

  Future<List<String>> get placeNames;

  Future<String> get roomTitle;
}

import '../../model/room_info.dart';
import '../../model/stats_snapshot.dart';

/// Interface for database service.
abstract class RoomConnection {
  // Modify stored value. May use transactions for safety.
  Future<void> incrementLocation(int index);
  Future<void> decrementLocation(int index);

  // Gets stored values from the database.
  Future<String> get title;
  Future<List<String>> get locations;
  Future<RoomInfo> get roomInfo;

  Stream<List<int>> get valuesStream;

  // Stats
  Future<StatsSnapshot> get stats;
}

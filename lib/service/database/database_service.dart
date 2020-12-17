import '../room/room_service.dart';

/// Interface for database service.
// ignore: one_member_abstracts
abstract class DatabaseService {
  /// Get a room service by name.
  Future<RoomService> getRoom(String roomName);
}

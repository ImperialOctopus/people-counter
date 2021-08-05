import '../room/room_connection.dart';

// ignore: one_member_abstracts
abstract class DatabaseService {
  Future<RoomConnection> getRoomByName(String name);
}

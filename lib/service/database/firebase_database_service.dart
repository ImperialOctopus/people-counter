import '../room/firebase_room_service.dart';
import '../room/room_service.dart';
import 'database_service.dart';

class FirebaseDatabaseService implements DatabaseService {
  @override
  Future<RoomService> getRoom(String roomName) async {
    return FirebaseRoomService(roomName);
  }
}

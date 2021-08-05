import '../room/firebase_room_connection.dart';
import 'database_service.dart';

class FirebaseDatabaseService implements DatabaseService {
  @override
  Future<FirebaseRoomConnection> getRoomByName(String name) async =>
      FirebaseRoomConnection(name);
}

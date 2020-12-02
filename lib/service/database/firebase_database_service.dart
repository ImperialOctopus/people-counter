import 'database_service.dart';

/// Database implementation using Firebase
class FirebaseDatabaseService implements DatabaseService {
  @override
  Future<void> modifyValue(int change) {
    // TODO: implement modifyValue
    throw UnimplementedError();
  }

  @override
  Future<void> setValue(int value) {
    // TODO: implement setValue
    throw UnimplementedError();
  }

  @override
  // TODO: implement valueStream
  Stream<int> get valueStream => throw UnimplementedError();
}

/// Interface for database service.
abstract class DatabaseService {
  /// Modify stored value. May use transactions for safety.
  Future<void> modifyValue(int index, int change);

  /// Sets stored value in the database.
  Future<void> setValue(int index, int value);

  /// Gets stored value from the database.
  Stream<Map<int, int>> get valueStream;
}

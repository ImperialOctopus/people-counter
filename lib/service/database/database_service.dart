/// Interface for database service.
abstract class DatabaseService {
  /// Modify stored value. May use transactions for safety.
  Future<void> modifyValue(int change);

  /// Sets stored value in the database.
  Future<void> setValue(int value);

  /// Gets stored value from the database.
  Stream<int> get valueStream;
}

/// Interface for database service.
abstract class DatabaseService {
  /// Modify stored value. May use transactions for safety.
  Future<void> modifyValue(int change);

  /// Gets stored value from the database.
  Future<int> getValue();

  /// Sets stored value in the database.
  Future<void> setValue(int value);
}

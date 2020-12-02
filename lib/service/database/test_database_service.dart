import 'database_service.dart';

/// Test database stored only locally.
class TestDatabaseService implements DatabaseService {
  int _value = 0;

  @override
  Future<int> getValue() async {
    return _value;
  }

  @override
  Future<void> modifyValue(int change) async {
    _value += change;
  }

  @override
  Future<void> setValue(int value) async {
    _value = value;
  }
}

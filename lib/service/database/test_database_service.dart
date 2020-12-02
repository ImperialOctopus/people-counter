import 'dart:async';

import 'database_service.dart';

/// Test database stored only locally.
class TestDatabaseService implements DatabaseService {
  int _value = 0;

  final _stream = StreamController<int>()..add(0);

  @override
  Stream<int> get valueStream async* {
    yield* _stream.stream;
  }

  @override
  Future<void> modifyValue(int change) async {
    _value += change;
    _stream.add(_value);
  }

  @override
  Future<void> setValue(int value) async {
    _value = value;
    _stream.add(_value);
  }
}

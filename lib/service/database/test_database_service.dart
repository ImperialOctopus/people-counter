import 'dart:async';

import 'database_service.dart';

/// Test database stored only locally.
class TestDatabaseService implements DatabaseService {
  final _stream = StreamController<int>()..add(0);

  @override
  Stream<int> get valueStream async* {
    yield* _stream.stream;
  }

  @override
  Future<void> modifyValue(int change) async {
    _stream.add(await _stream.stream.last + change);
  }

  @override
  Future<void> setValue(int value) async {
    _stream.add(value);
  }
}

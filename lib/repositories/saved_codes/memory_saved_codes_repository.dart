import 'dart:collection';

import 'package:people_counter/repositories/saved_codes/saved_codes_repository.dart';

class MemorySavedCodesRepository implements SavedCodesRepository {
  final Set<String> _codes = {};

  @override
  Future<UnmodifiableListView<String>> get getSavedCodes async =>
      UnmodifiableListView(_codes);

  @override
  Future<Iterable<String>> saveCode(String code) async {
    _codes.add(code);
    return getSavedCodes;
  }

  @override
  Future<Iterable<String>> removeCode(String code) async {
    _codes.remove(code);
    return getSavedCodes;
  }
}

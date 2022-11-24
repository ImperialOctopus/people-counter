import 'package:people_counter/repositories/saved_codes/saved_codes_repository.dart';

class MemorySavedCodesRepository implements SavedCodesRepository {
  final List<String> _codes = [];

  @override
  Future<List<String>> get getSavedCodes async => _codes;

  @override
  Future<void> saveCode(String code) async {
    _codes.add(code);
  }

  @override
  Future<void> removeCode(String code) async {
    _codes.remove(code);
  }
}

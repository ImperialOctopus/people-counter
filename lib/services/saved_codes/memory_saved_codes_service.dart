import 'package:people_counter/services/saved_codes/saved_codes_service.dart';

class MemorySavedCodesService implements SavedCodesService {
  final List<String> _codes = [];

  @override
  Future<List<String>> get getSavedCodes async => _codes;

  @override
  Future<void> saveCode(String code) async {
    _codes.add(code);
  }
}

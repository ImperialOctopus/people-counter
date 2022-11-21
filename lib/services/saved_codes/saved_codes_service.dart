abstract class SavedCodesService {
  Future<List<String>> get getSavedCodes;

  Future<void> saveCode(String code);

  Future<void> removeCode(String code);
}

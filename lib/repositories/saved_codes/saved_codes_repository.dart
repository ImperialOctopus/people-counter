abstract class SavedCodesRepository {
  Future<List<String>> get getSavedCodes;

  Future<void> saveCode(String code);

  Future<void> removeCode(String code);
}

abstract class SavedCodesRepository {
  Future<Iterable<String>> get getSavedCodes;

  Future<Iterable<String>> saveCode(String code);

  Future<Iterable<String>> removeCode(String code);
}

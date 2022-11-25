import 'package:people_counter/config.dart';
import 'package:people_counter/repositories/saved_codes/saved_codes_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSavedCodesRepository implements SavedCodesRepository {
  static const storageKey = 'event_codes';

  SharedPreferences? sharedPreferencesInstance;

  @override
  Future<Iterable<String>> get getSavedCodes async {
    sharedPreferencesInstance ??= await SharedPreferences.getInstance();
    final list = sharedPreferencesInstance!.getStringList(storageKey);
    if (list == null || list.isEmpty) {
      return _applyPresetEventsList();
    } else {
      return list;
    }
  }

  Future<Iterable<String>> _applyPresetEventsList() async {
    const presetList = Config.presetEventsList;

    sharedPreferencesInstance!.setStringList(storageKey, presetList.toList());

    return presetList;
  }

  @override
  Future<Iterable<String>> saveCode(String code) async {
    final codeList = (await getSavedCodes).toSet();

    codeList.add(code);

    sharedPreferencesInstance!.setStringList(storageKey, codeList.toList());

    return codeList;
  }

  @override
  Future<Iterable<String>> removeCode(String code) async {
    final codeList = (await getSavedCodes).toSet();

    codeList.remove(code);

    sharedPreferencesInstance!.setStringList(storageKey, codeList.toList());

    return codeList;
  }
}

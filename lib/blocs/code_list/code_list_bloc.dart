import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_counter/repositories/saved_codes/saved_codes_repository.dart';

import 'code_list_event.dart';
import 'code_list_state.dart';

class CodeListBloc extends Bloc<CodeListEvent, CodeListState> {
  final SavedCodesRepository savedCodesRepository;

  CodeListBloc({
    required this.savedCodesRepository,
  }) : super(const CodeListUnloaded()) {
    on<LoadSavedCodesEvent>(_onLoadSavedCodes);
    on<AddCodeEvent>(_onAddCode);
    on<RemoveCodeEvent>(_onRemoveCode);
  }

  void _onLoadSavedCodes(
      LoadSavedCodesEvent event, Emitter<CodeListState> emitter) async {
    emitter(const CodeListLoading('Loading saved codes...'));

    try {
      final list = await savedCodesRepository.getSavedCodes;
      emitter(CodeListLoaded(sortList(list)));
    } catch (e) {
      emitter(CodeListError(e.toString()));
    }
  }

  void _onAddCode(AddCodeEvent event, Emitter<CodeListState> emitter) async {
    try {
      final list = await savedCodesRepository.saveCode(event.code);
      emitter(CodeListLoaded(sortList(list)));
    } catch (e) {
      emitter(CodeListError(e.toString()));
    }
  }

  void _onRemoveCode(
      RemoveCodeEvent event, Emitter<CodeListState> emitter) async {
    try {
      final list = await savedCodesRepository.removeCode(event.code);
      emitter(CodeListLoaded(sortList(list)));
    } catch (e) {
      emitter(CodeListError(e.toString()));
    }
  }

  List<String> sortList(Iterable<String> list) {
    return list.toList()..sort();
  }
}

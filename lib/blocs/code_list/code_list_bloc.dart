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
      emitter(CodeListLoaded(list));
    } catch (e) {
      emitter(CodeListError(e.toString()));
    }
  }

  void _onAddCode(AddCodeEvent event, Emitter<CodeListState> emitter) async {
    final currentState = state;

    try {
      await savedCodesRepository.saveCode(event.code);

      if (currentState is CodeListLoaded) {
        emitter(CodeListLoaded([...currentState.codes, event.code]));
      } else {
        add(const LoadSavedCodesEvent());
      }
    } catch (e) {
      emitter(CodeListError(e.toString()));
    }
  }

  void _onRemoveCode(
      RemoveCodeEvent event, Emitter<CodeListState> emitter) async {
    final currentState = state;

    try {
      await savedCodesRepository.removeCode(event.code);

      if (currentState is CodeListLoaded) {
        emitter(
            CodeListLoaded(currentState.codes.toList()..remove(event.code)));
      } else {
        add(const LoadSavedCodesEvent());
      }
    } catch (e) {
      emitter(CodeListError(e.toString()));
    }
  }
}

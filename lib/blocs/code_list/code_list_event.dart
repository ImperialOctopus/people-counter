import 'package:equatable/equatable.dart';

abstract class CodeListEvent extends Equatable {
  const CodeListEvent();
}

class LoadSavedCodesEvent extends CodeListEvent {
  const LoadSavedCodesEvent();

  @override
  List<Object?> get props => [];
}

class AddCodeEvent extends CodeListEvent {
  final String code;

  const AddCodeEvent(this.code);

  @override
  List<Object?> get props => [code];
}

class RemoveCodeEvent extends CodeListEvent {
  final String code;

  const RemoveCodeEvent(this.code);

  @override
  List<Object?> get props => [code];
}

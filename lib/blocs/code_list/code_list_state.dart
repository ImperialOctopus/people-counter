import 'package:equatable/equatable.dart';

abstract class CodeListState extends Equatable {
  const CodeListState();
}

class CodeListUnloaded extends CodeListState {
  const CodeListUnloaded();

  @override
  List<Object> get props => [];
}

class CodeListLoading extends CodeListState {
  final String message;

  const CodeListLoading(this.message);

  @override
  List<Object> get props => [message];
}

class CodeListLoaded extends CodeListState {
  final Iterable<String> codes;

  const CodeListLoaded(this.codes);

  @override
  List<Object> get props => [codes];
}

class CodeListError extends CodeListState {
  final String message;

  const CodeListError(this.message);

  @override
  List<Object> get props => [message];
}

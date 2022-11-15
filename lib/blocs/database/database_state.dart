import 'package:equatable/equatable.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();
}

class DatabaseUnloaded extends DatabaseState {
  const DatabaseUnloaded();

  @override
  List<Object> get props => [];
}

class DatabaseLoading extends DatabaseState {
  const DatabaseLoading();

  @override
  List<Object> get props => [];
}

class DatabaseLoaded extends DatabaseState {
  const DatabaseLoaded();

  @override
  List<Object> get props => [];
}

class DatabaseError extends DatabaseState {
  final String message;

  const DatabaseError([this.message = '']);

  @override
  List<Object> get props => [message];
}

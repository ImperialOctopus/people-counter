import 'package:equatable/equatable.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();
}

class RoomStateNone extends RoomState {
  const RoomStateNone();

  @override
  List<Object> get props => [];
}

class RoomStateLoading extends RoomState {
  @override
  List<Object> get props => [];
}

class RoomStateIn extends RoomState {
  final RoomConnection roomConnection;
  final RoomInfo roomInfo;

  const RoomStateIn(this.roomConnection, this.roomInfo);

  @override
  List<Object> get props => [roomConnection];
}

class RoomStateError extends RoomState {
  final String message;

  const RoomStateError([this.message = '']);

  @override
  List<Object> get props => [message];
}

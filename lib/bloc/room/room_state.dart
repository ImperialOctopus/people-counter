import 'package:equatable/equatable.dart';

import '../../service/room/room_connection.dart';

abstract class RoomState extends Equatable {
  const RoomState();
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
  final String title;
  final List<String> locations;

  const RoomStateIn(this.roomConnection, this.title, this.locations);

  @override
  List<Object> get props => [roomConnection, title, locations];
}

class RoomStateError extends RoomState {
  final String message;

  const RoomStateError([this.message = '']);

  @override
  List<Object> get props => [message];
}

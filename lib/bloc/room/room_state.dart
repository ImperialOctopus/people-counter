import 'package:equatable/equatable.dart';

import '../../service/room/room_connection.dart';

abstract class RoomState extends Equatable {
  const RoomState();
}

class OutRoom extends RoomState {
  const OutRoom();

  @override
  List<Object> get props => [];
}

class LoadingRoom extends RoomState {
  @override
  List<Object> get props => [];
}

class InRoom extends RoomState {
  final RoomConnection roomConnection;
  final String name;
  final List<String> placeNames;

  const InRoom(this.roomConnection, this.name, this.placeNames);

  @override
  List<Object> get props => [roomConnection, name, placeNames];
}

class RoomLoadError extends RoomState {
  final String message;

  const RoomLoadError([this.message = '']);

  @override
  List<Object> get props => [message];
}

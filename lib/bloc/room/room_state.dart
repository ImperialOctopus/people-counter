import 'package:equatable/equatable.dart';

import '../../service/room/room_service.dart';

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
  final RoomService roomService;
  final String name;
  final List<String> placeNames;

  const InRoom(this.roomService, this.name, this.placeNames);

  @override
  List<Object> get props => [roomService, name, placeNames];
}

class RoomLoadError extends RoomState {
  final String message;

  const RoomLoadError(this.message);

  @override
  List<Object> get props => [message];
}

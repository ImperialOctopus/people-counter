import 'package:equatable/equatable.dart';

abstract class RoomState extends Equatable {
  const RoomState();
}

class OutRoom extends RoomState {
  const OutRoom();

  @override
  List<Object> get props => [];
}

class InRoom extends RoomState {
  final String roomName;

  const InRoom(this.roomName);

  @override
  List<Object> get props => [roomName];
}

import 'package:equatable/equatable.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();
}

class AppStartedEvent extends DatabaseEvent {

}

class LoadDatabaseEvent extends DatabaseEvent {

}

class 

class LeaveRoomEvent extends RoomEvent {
  const LeaveRoomEvent();

  @override
  List<Object> get props => [];
}

class EnterRoomEvent extends RoomEvent {
  final String roomName;

  const EnterRoomEvent(this.roomName);

  @override
  List<Object> get props => [roomName];
}

import 'package:flutter_bloc/flutter_bloc.dart';

import 'room_event.dart';
import 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(const OutRoom());

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    if (event is LeaveRoomEvent) {
      yield const OutRoom();
    }
    if (event is EnterRoomEvent) {
      yield InRoom(event.roomName);
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/database/database_service.dart';
import 'room_event.dart';
import 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final DatabaseService databaseService;

  RoomBloc(this.databaseService) : super(const OutRoom());

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    if (event is LeaveRoomEvent) {
      yield const OutRoom();
    }
    if (event is EnterRoomEvent) {
      yield* _mapEnterRoomToState(event);
    }
  }

  Stream<RoomState> _mapEnterRoomToState(EnterRoomEvent event) async* {
    yield LoadingRoom();
    try {
      final roomService = await databaseService.getRoomByName(event.roomName);
      final title = await roomService.title;
      final placeNames = await roomService.locations;

      yield InRoom(roomService, title, placeNames);
      // Error changes by platform
    } catch (e) {
      yield const RoomLoadError();
    }
  }
}

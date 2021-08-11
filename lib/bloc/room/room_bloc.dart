import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/database/database_service.dart';
import 'room_event.dart';
import 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final DatabaseService databaseService;

  RoomBloc(this.databaseService) : super(const RoomStateNone());

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    if (event is LeaveRoomEvent) {
      yield const RoomStateNone();
      return;
    }
    if (event is EnterRoomEvent) {
      yield* _mapEnterRoomToState(event);
      return;
    }
    throw FallThroughError();
  }

  Stream<RoomState> _mapEnterRoomToState(EnterRoomEvent event) async* {
    yield RoomStateLoading();
    try {
      final roomService = await databaseService.getRoomByName(event.roomName);
      final title = await roomService.title;
      final locations = await roomService.locations;

      yield RoomStateIn(roomService, title, locations);
      // Error changes by platform
    } catch (e) {
      yield const RoomStateError();
    }
  }
}

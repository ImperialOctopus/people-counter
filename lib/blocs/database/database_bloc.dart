import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/database/database_service.dart';
import 'database_event.dart';
import 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseService databaseService;

  DatabaseBloc(this.databaseService) : super(const DatabaseUnloaded())
  {
    on<
  }

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
      final roomInfo = await roomService.roomInfo;

      yield RoomStateIn(roomService, roomInfo);
      // Error changes by platform
    } catch (e) {
      yield const RoomStateError();
    }
  }
}

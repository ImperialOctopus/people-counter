import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/room/room_connection.dart';
import 'stats_event.dart';
import 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final RoomConnection _roomConnection;

  StatsBloc({required RoomConnection roomConnection})
      : _roomConnection = roomConnection,
        super(const StatsNotLoaded());

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is LoadStatsEvent) {
      yield const StatsLoading();

      final _stats = await _roomConnection.stats;

      yield StatsLoaded(_stats, DateTime.now());
      return;
    }

    throw FallThroughError();
  }
}

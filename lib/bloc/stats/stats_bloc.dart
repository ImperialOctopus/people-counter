import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/room/room_connection.dart';
import 'stats_event.dart';
import 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final RoomConnection _roomConnection;

  late final StreamSubscription _streamSubscription;

  StatsBloc({required RoomConnection roomConnection})
      : _roomConnection = roomConnection,
        super(const StatsLoading()) {
    _streamSubscription = _roomConnection.statsStream.listen((value) {
      add(StatsChangedEvent(value));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is StatsChangedEvent) {
      yield StatsLoaded(event.snapshot);
    }
    if (event is ResetStatsEvent) {
      _roomConnection.resetStats();
    }
  }
}

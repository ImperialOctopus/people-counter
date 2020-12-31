import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/room/room_service.dart';
import 'stats_event.dart';
import 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final RoomService _roomService;

  StreamSubscription _streamSubscription;

  StatsBloc({@required RoomService roomService})
      : _roomService = roomService,
        super(const StatsLoading()) {
    _streamSubscription = _roomService.statsStream.listen((value) {
      add(StatsChangedEvent(value));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is StatsChangedEvent) {
      yield StatsLoaded(event.snapshot);
    }
    if (event is ResetStatsEvent) {
      _roomService.resetStats();
    }
  }
}

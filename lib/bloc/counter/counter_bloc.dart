import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/database/database_service.dart';
import 'counter_event.dart';

/// Cubit to hold main count.
class CounterBloc extends Bloc<CounterEvent, Map<int, int>> {
  final DatabaseService _databaseService;

  /// Cubit to hold main count.
  CounterBloc({@required DatabaseService databaseService})
      : _databaseService = databaseService,
        super({0: 0, 1: 0, 2: 0, 3: 0}) {
    _databaseService.valueStream.listen((value) {
      add(ReceivedChangeCounterEvent(value));
    });
  }

  @override
  Stream<Map<int, int>> mapEventToState(CounterEvent event) async* {
    if (event is ReceivedChangeCounterEvent) {
      yield* _mapReceivedChangeToState(event);
    }
    if (event is ModifyCounterEvent) {
      yield* _mapModifyToState(event);
    }
    if (event is SetCounterEvent) {
      yield* _mapSetToState(event);
    }
  }

  Stream<Map<int, int>> _mapReceivedChangeToState(
      ReceivedChangeCounterEvent event) async* {
    yield event.value;
  }

  Stream<Map<int, int>> _mapModifyToState(ModifyCounterEvent event) async* {
    yield state.map((key, value) {
      if (key == event.index) {
        return MapEntry(
          key,
          (value + event.change < 0) ? 0 : value + event.change,
        );
      } else {
        return MapEntry(key, value);
      }
    });

    await _databaseService.modifyValue(event.index, event.change);
  }

  Stream<Map<int, int>> _mapSetToState(SetCounterEvent event) async* {
    _databaseService.setValue(event.index, event.value);
  }
}

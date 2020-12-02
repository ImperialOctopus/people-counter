import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/database/database_service.dart';
import 'counter_event.dart';
import 'counter_state.dart';

/// Cubit to hold main count.
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final DatabaseService _databaseService;

  /// Cubit to hold main count.
  CounterBloc({@required DatabaseService databaseService})
      : _databaseService = databaseService,
        super(CounterStateUninitialised()) {
    _databaseService.valueStream.listen((value) {
      add(LoadCounterEvent(value));
    });
  }

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is LoadCounterEvent) {
      yield* _mapLoadedToState(event);
    }
    if (event is ModifyCounterEvent) {
      yield* _mapModifyToState(event);
    }
  }

  Stream<CounterState> _mapLoadedToState(LoadCounterEvent event) async* {
    yield CounterStateLoaded(event.value);
  }

  Stream<CounterState> _mapModifyToState(ModifyCounterEvent event) async* {
    await _databaseService.modifyValue(event.change);
  }
}

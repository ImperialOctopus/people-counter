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
        super(CounterStateUninitialised());

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is InitialiseCounterEvent) {
      yield* _mapInitialiseToState(event);
    }
    if (event is IncrementCounterEvent) {
      yield* _mapIncrementToState(event);
    }
    if (event is DecrementCounterEvent) {
      yield* _mapDecrementToState(event);
    }
  }

  Stream<CounterState> _mapInitialiseToState(
      InitialiseCounterEvent event) async* {
    _databaseService.getValue();
  }

  Stream<CounterState> _mapIncrementToState(
      IncrementCounterEvent event) async* {}

  Stream<CounterState> _mapDecrementToState(
      DecrementCounterEvent event) async* {}
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/database/database_service.dart';
import 'counter_event.dart';

/// Cubit to hold main count.
class CounterBloc extends Bloc<CounterEvent, int> {
  final DatabaseService _databaseService;

  /// Cubit to hold main count.
  CounterBloc({@required DatabaseService databaseService})
      : _databaseService = databaseService,
        super(0) {
    _databaseService.valueStream.listen((value) {
      add(ReceivedChangeCounterEvent(value));
    });
  }

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event is ReceivedChangeCounterEvent) {
      yield* _mapReceivedChangeToState(event);
    }
    if (event is ModifyCounterEvent) {
      yield* _mapModifyToState(event);
    }
  }

  Stream<int> _mapReceivedChangeToState(
      ReceivedChangeCounterEvent event) async* {
    yield event.value;
  }

  Stream<int> _mapModifyToState(ModifyCounterEvent event) async* {
    yield state + event.change;
    await _databaseService.modifyValue(event.change);
  }
}

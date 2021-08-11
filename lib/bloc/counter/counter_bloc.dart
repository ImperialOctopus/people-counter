import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/room/room_connection.dart';
import 'counter_event.dart';
import 'counter_state.dart';

/// Cubit to hold main count.
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final RoomConnection _roomConnection;

  Timer? _timer;
  late final StreamSubscription _streamSubscription;

  /// Cubit to hold main count.
  CounterBloc({required RoomConnection roomConnection})
      : _roomConnection = roomConnection,
        super(const CounterStateLoading()) {
    _streamSubscription = _roomConnection.valuesStream.listen((value) {
      add(CounterEventReceivedChange(value));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _streamSubscription.cancel();
    return super.close();
  }

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is CounterEventReceivedChange) {
      yield* _mapReceivedChangeToState(event);
      return;
    }
    if (event is CounterEventChange) {
      yield* _mapModifyToState(event);
      return;
    }
    if (event is CounterEventReset) {
      yield* _mapResetToState(event);
      return;
    }
    if (event is CounterEventEndDebounce) {
      yield* _mapDebounceEndedToState(event);
      return;
    }
    throw FallThroughError();
  }

  Stream<CounterState> _mapReceivedChangeToState(
      CounterEventReceivedChange event) async* {
    if (state is CounterStateDebounce) {
      yield CounterStateDebounce(
          (state as CounterStateDebounce).value, event.value);
    } else {
      yield CounterStateLive(event.value);
    }
  }

  Stream<CounterState> _mapModifyToState(CounterEventChange event) async* {
    if (state is! CounterStateLive) {
      return;
    } else {
      final currentState = (state as CounterStateLive).live;
      final newState = currentState
          .asMap()
          .map((key, value) {
            if (key == event.index) {
              return MapEntry(
                key,
                (value + event.change < 0) ? 0 : value + event.change,
              );
            } else {
              return MapEntry(key, value);
            }
          })
          .values
          .toList();
      yield CounterStateDebounce(newState, newState);
      _resetDebounceTimer();
      if (event.change == 1) {
        _roomConnection.incrementLocation(event.index);
      } else {
        _roomConnection.decrementLocation(event.index);
      }
    }
  }

  Stream<CounterState> _mapResetToState(CounterEventReset event) async* {
    _roomConnection.resetLocation(event.index);
  }

  Stream<CounterState> _mapDebounceEndedToState(
      CounterEventEndDebounce event) async* {
    yield CounterStateLive(event.value);
  }

  void _resetDebounceTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 200), _debounceDelayEnded);
  }

  void _debounceDelayEnded() {
    if (state is CounterStateLive) {
      add(CounterEventEndDebounce((state as CounterStateLive).live));
    }
  }
}

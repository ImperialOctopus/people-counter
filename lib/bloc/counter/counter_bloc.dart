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
        super(const LoadingCounterState()) {
    _streamSubscription = _roomConnection.valuesStream.listen((value) {
      add(ReceivedChangeCounterEvent(value));
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
    if (event is ReceivedChangeCounterEvent) {
      yield* _mapReceivedChangeToState(event);
    }
    if (event is ModifyCounterEvent) {
      yield* _mapModifyToState(event);
    }
    if (event is ResetCounterEvent) {
      yield* _mapResetToState(event);
    }
    if (event is DebounceEndedEvent) {
      yield* _mapDebounceEndedToState(event);
    }
  }

  Stream<CounterState> _mapReceivedChangeToState(
      ReceivedChangeCounterEvent event) async* {
    if (state is DebouncedCounterState) {
      yield DebouncedCounterState(
          (state as DebouncedCounterState).value, event.value);
    } else {
      yield LiveCounterState(event.value);
    }
  }

  Stream<CounterState> _mapModifyToState(ModifyCounterEvent event) async* {
    if (state is! LiveCounterState) {
      return;
    } else {
      final currentState = (state as LiveCounterState).live;
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
      yield DebouncedCounterState(newState, newState);
      _resetDebounceTimer();
      if (event.change == 1) {
        _roomConnection.incrementLocation(event.index);
      } else {
        _roomConnection.decrementLocation(event.index);
      }
    }
  }

  Stream<CounterState> _mapResetToState(ResetCounterEvent event) async* {
    _roomConnection.resetLocation(event.index);
  }

  Stream<CounterState> _mapDebounceEndedToState(
      DebounceEndedEvent event) async* {
    yield LiveCounterState(event.value);
  }

  void _resetDebounceTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 200), _debounceDelayEnded);
  }

  void _debounceDelayEnded() {
    if (state is LiveCounterState) {
      add(DebounceEndedEvent((state as LiveCounterState).live));
    }
  }
}

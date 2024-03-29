import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people_counter/config.dart';
import 'package:people_counter/repositories/events/events_repository.dart';

/// Cubit to hold main count.
class CounterCubit extends Cubit<int> {
  static const _debounceDelay = Config.counterDebounceDelay;

  final LocationConnection _locationConnection;

  late final StreamSubscription<int> _streamSubscription;

  Timer? _debounceTimer;
  int _debounceHeldValue = 0;

  /// Cubit to hold main count.
  CounterCubit({required LocationConnection locationConnection})
      : _locationConnection = locationConnection,
        super(locationConnection.current) {
    _streamSubscription =
        locationConnection.valuesStream.listen(_onValueReceived);
  }

  void recordEntry() {
    emit(state + 1);
    _setDebounceTimer();
    _locationConnection.sendIncrement();
  }

  void recordExit() {
    emit(state - 1);
    _setDebounceTimer();
    _locationConnection.sendDecrement();
  }

  void recordReset() {
    emit(0);
    _setDebounceTimer();
    _locationConnection.sendReset();
  }

  void _onValueReceived(int value) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceHeldValue = value;
    } else {
      emit(value);
    }
  }

  void _setDebounceTimer() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDelay, () => emit(_debounceHeldValue));
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    _streamSubscription.cancel();
    return super.close();
  }
}

import 'package:equatable/equatable.dart';

/// Event for counter bloc.
abstract class CounterEvent extends Equatable {
  /// Event for counter bloc.
  const CounterEvent();
}

/// Initialise counter.
class InitialiseCounterEvent extends CounterEvent {
  /// Initialise counter.
  const InitialiseCounterEvent();

  @override
  List<Object> get props => [];
}

/// Counter number changed.
class LoadCounterEvent extends CounterEvent {
  /// New value.
  final int value;

  /// Counter number changed.
  const LoadCounterEvent(this.value);

  @override
  List<Object> get props => [value];
}

/// Modify counter.
class ModifyCounterEvent extends CounterEvent {
  /// Number to change by.
  final int change;

  /// Modify counter.
  const ModifyCounterEvent(this.change);

  @override
  List<Object> get props => [change];
}

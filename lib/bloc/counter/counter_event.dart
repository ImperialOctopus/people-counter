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

/// Add 1 to counter.
class IncrementCounterEvent extends CounterEvent {
  /// Add 1 to counter.
  const IncrementCounterEvent();

  @override
  List<Object> get props => [];
}

/// Remove 1 from counter.
class DecrementCounterEvent extends CounterEvent {
  /// Remove 1 from counter.
  const DecrementCounterEvent();

  @override
  List<Object> get props => [];
}

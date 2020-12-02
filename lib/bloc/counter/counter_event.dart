import 'package:equatable/equatable.dart';

/// Event for counter bloc.
abstract class CounterEvent extends Equatable {
  /// Event for counter bloc.
  const CounterEvent();
}

/// Counter number changed.
class ReceivedChangeCounterEvent extends CounterEvent {
  /// New value.
  final int value;

  /// Counter number changed.
  const ReceivedChangeCounterEvent(this.value);

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

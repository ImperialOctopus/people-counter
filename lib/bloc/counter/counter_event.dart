import 'package:equatable/equatable.dart';

/// Event for counter bloc.
abstract class CounterEvent extends Equatable {
  /// Event for counter bloc.
  const CounterEvent();
}

/// Counter number changed.
class ReceivedChangeCounterEvent extends CounterEvent {
  /// New value.
  final Map<int, int> value;

  /// Counter number changed.
  const ReceivedChangeCounterEvent(this.value);

  @override
  List<Object> get props => [value];
}

/// Modify counter.
class ModifyCounterEvent extends CounterEvent {
  final int index;

  /// Number to change by.
  final int change;

  /// Modify counter.
  const ModifyCounterEvent(this.index, this.change);

  @override
  List<Object> get props => [index, change];
}

class SetCounterEvent extends CounterEvent {
  final int index;
  final int value;

  const SetCounterEvent(this.index, this.value);

  @override
  List<Object> get props => [index, value];
}

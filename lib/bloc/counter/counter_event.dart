import 'package:equatable/equatable.dart';

/// Event for counter bloc.
abstract class CounterEvent extends Equatable {
  /// Event for counter bloc.
  const CounterEvent();
}

/// Counter number changed.
class ReceivedChangeCounterEvent extends CounterEvent {
  /// New value.
  final List<int> value;

  /// Counter number changed.
  const ReceivedChangeCounterEvent(this.value);

  @override
  List<Object> get props => [value];
}

abstract class ModifyCounterEvent extends CounterEvent {
  final int index;

  int get change;

  const ModifyCounterEvent(this.index);

  @override
  List<Object> get props => [index];
}

class IncrementCounterEvent extends ModifyCounterEvent {
  const IncrementCounterEvent(int index) : super(index);

  @override
  int get change => 1;
}

class DecrementCounterEvent extends ModifyCounterEvent {
  const DecrementCounterEvent(int index) : super(index);

  @override
  int get change => -1;
}

class ResetCounterEvent extends CounterEvent {
  final int index;

  const ResetCounterEvent(this.index);

  @override
  List<Object> get props => [index];
}

class DebounceEndedEvent extends CounterEvent {
  final List<int> value;

  const DebounceEndedEvent(this.value);

  @override
  List<Object> get props => [value];
}

import 'package:equatable/equatable.dart';

/// Event for counter bloc.
abstract class CounterEvent extends Equatable {
  /// Event for counter bloc.
  const CounterEvent();
}

/// Counter number changed.
class CounterEventReceivedChange extends CounterEvent {
  /// New value.
  final int value;

  /// Counter number changed.
  const CounterEventReceivedChange(this.value);

  @override
  List<Object> get props => [value];
}

abstract class CounterEventChange extends CounterEvent {
  int get change;

  const CounterEventChange();

  @override
  List<Object> get props => [];
}

class CounterEventIncrement extends CounterEventChange {
  const CounterEventIncrement() : super();

  @override
  int get change => 1;
}

class CounterEventDecrement extends CounterEventChange {
  const CounterEventDecrement() : super();

  @override
  int get change => -1;
}

class CounterEventEndDebounce extends CounterEvent {
  final int value;

  const CounterEventEndDebounce(this.value);

  @override
  List<Object> get props => [value];
}

class CounterEventReset extends CounterEvent {
  const CounterEventReset();

  @override
  List<Object?> get props => [];
}

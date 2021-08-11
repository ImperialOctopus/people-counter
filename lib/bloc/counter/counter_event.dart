import 'package:equatable/equatable.dart';

/// Event for counter bloc.
abstract class CounterEvent extends Equatable {
  /// Event for counter bloc.
  const CounterEvent();
}

/// Counter number changed.
class CounterEventReceivedChange extends CounterEvent {
  /// New value.
  final List<int> value;

  /// Counter number changed.
  const CounterEventReceivedChange(this.value);

  @override
  List<Object> get props => [value];
}

abstract class CounterEventChange extends CounterEvent {
  final int index;

  int get change;

  const CounterEventChange(this.index);

  @override
  List<Object> get props => [index];
}

class CounterEventIncrement extends CounterEventChange {
  const CounterEventIncrement(int index) : super(index);

  @override
  int get change => 1;
}

class CounterEventDecrement extends CounterEventChange {
  const CounterEventDecrement(int index) : super(index);

  @override
  int get change => -1;
}

class CounterEventEndDebounce extends CounterEvent {
  final List<int> value;

  const CounterEventEndDebounce(this.value);

  @override
  List<Object> get props => [value];
}

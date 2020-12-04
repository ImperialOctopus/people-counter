import 'package:equatable/equatable.dart';

abstract class CounterState extends Equatable {
  const CounterState();
}

class LoadingCounterState extends CounterState {
  const LoadingCounterState();

  @override
  List<Object> get props => [];
}

class LiveCounterState extends CounterState {
  final Map<int, int> value;
  Map<int, int> get live => value;

  const LiveCounterState(this.value);

  @override
  List<Object> get props => [value];
}

class DebouncedCounterState extends LiveCounterState {
  final Map<int, int> live;

  const DebouncedCounterState(Map<int, int> value, this.live) : super(value);

  @override
  List<Object> get props => [value, live];
}

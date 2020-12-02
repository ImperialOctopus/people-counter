import 'package:equatable/equatable.dart';

/// State for counter bloc.
abstract class CounterState extends Equatable {
  /// State for counter bloc.
  const CounterState();
}

/// Counter uninitialised.
class CounterStateUninitialised extends CounterState {
  /// Counter uninitialised.
  const CounterStateUninitialised();

  @override
  List<Object> get props => [];
}

/// Counter value loaded.
class CounterStateLoaded extends CounterState {
  /// Value on the counter.
  final int value;

  /// Counter value loaded.
  const CounterStateLoaded(this.value);

  @override
  List<Object> get props => [value];
}

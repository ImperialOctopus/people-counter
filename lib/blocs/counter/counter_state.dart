import 'package:equatable/equatable.dart';

abstract class CounterState extends Equatable {
  const CounterState();
}

class CounterStateLoading extends CounterState {
  const CounterStateLoading();

  @override
  List<Object> get props => [];
}

class CounterStateLive extends CounterState {
  final int value;
  int get live => value;

  const CounterStateLive(this.value);

  @override
  List<Object> get props => [value];
}

class CounterStateDebounce extends CounterStateLive {
  @override
  final int live;

  const CounterStateDebounce(super.value, this.live);

  @override
  List<Object> get props => [value, live];
}

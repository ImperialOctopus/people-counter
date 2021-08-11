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
  final List<int> value;
  List<int> get live => value;

  const CounterStateLive(this.value);

  @override
  List<Object> get props => [value];
}

class CounterStateDebounce extends CounterStateLive {
  @override
  final List<int> live;

  const CounterStateDebounce(List<int> value, this.live) : super(value);

  @override
  List<Object> get props => [value, live];
}

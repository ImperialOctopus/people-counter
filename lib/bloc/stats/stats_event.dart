import 'package:equatable/equatable.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class LoadStatsEvent extends StatsEvent {
  const LoadStatsEvent();

  @override
  List<Object> get props => [];
}

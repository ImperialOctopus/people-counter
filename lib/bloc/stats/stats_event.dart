import 'package:equatable/equatable.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class ReloadStatsEvent extends StatsEvent {
  const ReloadStatsEvent();

  @override
  List<Object> get props => [];
}

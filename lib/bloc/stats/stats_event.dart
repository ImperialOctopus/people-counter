import 'package:equatable/equatable.dart';

import '../../model/stats_snapshot.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class StatsChangedEvent extends StatsEvent {
  final StatsSnapshot snapshot;

  const StatsChangedEvent(this.snapshot);

  @override
  List<Object> get props => [snapshot];
}

class ResetStatsEvent extends StatsEvent {
  const ResetStatsEvent();

  @override
  List<Object> get props => [];
}

import 'package:equatable/equatable.dart';

import '../../model/stats_snapshot.dart';

abstract class StatsState extends Equatable {
  const StatsState();
}

abstract class StatsHasStats {
  StatsSnapshot get snapshot;

  DateTime get generatedAt;
}

abstract class StatsIsLoading {}

class StatsNotLoaded extends StatsState {
  const StatsNotLoaded();

  @override
  List<Object?> get props => [];
}

class StatsLoading extends StatsState implements StatsIsLoading {
  const StatsLoading();

  @override
  List<Object> get props => [];
}

class StatsLoaded extends StatsState implements StatsHasStats {
  @override
  final StatsSnapshot snapshot;

  @override
  final DateTime generatedAt;

  const StatsLoaded(this.snapshot, this.generatedAt);

  @override
  List<Object> get props => [snapshot, generatedAt];
}

class StatsReloading extends StatsLoaded
    implements StatsHasStats, StatsIsLoading {
  const StatsReloading(StatsSnapshot snapshot, DateTime generatedAt)
      : super(snapshot, generatedAt);
}

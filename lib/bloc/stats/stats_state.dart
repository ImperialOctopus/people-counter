import 'package:equatable/equatable.dart';

import '../../model/stats_snapshot.dart';

abstract class StatsState extends Equatable {
  const StatsState();
}

class StatsNotLoaded extends StatsState {
  const StatsNotLoaded();

  @override
  List<Object?> get props => [];
}

class StatsLoading extends StatsState {
  const StatsLoading();

  @override
  List<Object> get props => [];
}

class StatsLoaded extends StatsState {
  final StatsSnapshot snapshot;

  final DateTime generatedAt;

  const StatsLoaded(this.snapshot, this.generatedAt);

  @override
  List<Object> get props => [snapshot, generatedAt];
}

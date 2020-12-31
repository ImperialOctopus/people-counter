import 'package:equatable/equatable.dart';

import '../../model/stats_snapshot.dart';

abstract class StatsState extends Equatable {
  const StatsState();
}

class StatsLoading extends StatsState {
  const StatsLoading();

  @override
  List<Object> get props => [];
}

class StatsLoaded extends StatsState {
  final StatsSnapshot snapshot;

  const StatsLoaded(this.snapshot);

  @override
  List<Object> get props => [snapshot];
}

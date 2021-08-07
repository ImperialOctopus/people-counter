import 'package:equatable/equatable.dart';
import 'package:people_counter/model/log_entry.dart';

class StatsSnapshot extends Equatable {
  final List<LogEntry> logs;

  const StatsSnapshot({required this.logs});

  @override
  List<Object?> get props => logs;
}

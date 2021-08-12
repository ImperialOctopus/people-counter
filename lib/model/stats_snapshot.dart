import 'package:equatable/equatable.dart';
import 'package:people_counter/model/log_entry.dart';
import 'package:people_counter/model/log_entry_type.dart';

class StatsSnapshot extends Equatable {
  final List<LogEntry> logs;

  const StatsSnapshot({required this.logs});

  @override
  List<Object?> get props => logs;

  /// Total number of people entered into any location
  int get totalEntries =>
      logs.where((element) => element.type == LogEntryType.entry).length;
}

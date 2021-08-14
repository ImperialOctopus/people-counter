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

  int totalBefore(DateTime time) {
    return logs.where((log) => log.time.isBefore(time)).fold<int>(0,
        (previousValue, log) {
      switch (log.type) {
        case LogEntryType.entry:
          return previousValue + 1;
        case LogEntryType.exit:
          return previousValue - 1;
        default:
          throw FallThroughError();
      }
    });
  }

  List<LogEntry> logsBetween({required DateTime start, required DateTime end}) {
    return logs
        .where((log) => log.time.isAfter(start) && log.time.isBefore(end))
        .toList();
  }
}

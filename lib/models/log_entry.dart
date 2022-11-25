import 'package:equatable/equatable.dart';

import 'log_entry_type.dart';

class LogEntry extends Equatable implements Comparable {
  final LogEntryType type;
  final DateTime time;
  final int location;

  const LogEntry({
    required this.type,
    required this.time,
    required this.location,
  });

  LogEntry.entry({required this.location})
      : type = LogEntryType.entry,
        time = DateTime.now();

  LogEntry.exit({required this.location})
      : type = LogEntryType.exit,
        time = DateTime.now();

  LogEntry.reset({required this.location})
      : type = LogEntryType.reset,
        time = DateTime.now();

  static LogEntry fromFirebaseData(Map<String, dynamic> data) {
    return LogEntry(
      type: LogEntryType.values[(data['type'] ?? 0)],
      time: DateTime.fromMillisecondsSinceEpoch(data['time'] ?? 0),
      location: data['location'] ?? 0,
    );
  }

  Map<String, int> get toFirebaseData => <String, int>{
        'type': type.index,
        'time': time.millisecondsSinceEpoch,
        'location': location,
      };

  @override
  int compareTo(other) {
    if (other is LogEntry) {
      return time.compareTo(other.time);
    }
    return 0;
  }

  @override
  List<Object?> get props => [type, time, location];
}

/// Type of an entry in the log.
class LogEntryType {
  /// Enum index.
  final int index;

  /// toString result.
  final String _text;

  const LogEntryType._(this.index, String text) : _text = text;

  /// Create a log entry type from its index.
  factory LogEntryType.fromIndex(int _index) => _all[_index];

  @override
  String toString() => _text;

  static const List<LogEntryType> _all = [
    entry,
    exit,
  ];

  /// Someone entered.
  static const LogEntryType entry = LogEntryType._(0, 'Entry');

  /// Someone left.
  static const LogEntryType exit = LogEntryType._(1, 'Exit');
}

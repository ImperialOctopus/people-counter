/// Type of an entry in the log.
enum LogEntryType {
  entry('Entry'),
  exit('Exit'),
  reset('Reset');

  final String _text;

  const LogEntryType(this._text);

  @override
  String toString() => _text;
}

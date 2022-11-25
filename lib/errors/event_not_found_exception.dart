class EventNotFoundException implements Exception {
  final String? message;

  const EventNotFoundException([this.message]);
}

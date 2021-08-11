import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:people_counter/model/room_info.dart';

import '../../model/log_entry.dart';
import '../../model/stats_snapshot.dart';
import 'room_connection.dart';

/// Database implementation using Firebase
class FirebaseRoomConnection implements RoomConnection {
  static const String _defaultTitle = 'Unknown Event';
  static const List<String> _defaultLocations = [];

  final String roomName;

  late final CollectionReference<Map<String, dynamic>> _collectionReference;

  Future<List<String>>? _locations;
  Future<String>? _title;
  Stream<List<int>>? _valuesStream;

  FirebaseRoomConnection(this.roomName) {
    // Sets the reference to collection at root/{room name}
    _collectionReference = FirebaseFirestore.instance.collection(roomName);

    locations;
    title;
    valuesStream;
  }

  /// Static information
  @override
  Future<List<String>> get locations async {
    _locations ??= _collectionReference.doc('locations').get().then((value) =>
        (value.data()?['names'] as List<dynamic>?)?.cast<String>() ??
        _defaultLocations);
    return _locations!;
  }

  @override
  Future<String> get title async {
    _title ??= _collectionReference
        .doc('meta')
        .get()
        .then((value) => value.data()?['name'] as String? ?? _defaultTitle);

    return _title!;
  }

  @override
  Future<RoomInfo> get roomInfo async {
    return RoomInfo(title: await title, locations: await locations);
  }

  @override
  Stream<List<int>> get valuesStream {
    _valuesStream ??= _collectionReference
        .doc('locations')
        .snapshots()
        .map<List<int>>((snapshot) =>
            (snapshot.data()?['values'] as List<dynamic>).cast<int>());
    return _valuesStream!;
  }

  Stream<int> get totalStream =>
      valuesStream.map((list) => list.fold(0, (a, b) => a + b));

  @override
  Future<void> incrementLocation(int index) async {
    await _updateLocation(index,
        validator: (i) => true, transform: (i) => i + 1);
    await _addStat(LogEntry.entry(location: index));
  }

  @override
  Future<void> decrementLocation(int index) async {
    if (await _updateLocation(
      index,
      validator: (i) => i > 0,
      transform: (i) => i - 1,
    )) {
      await _addStat(LogEntry.exit(location: index));
    }
  }

  Future<bool> _updateLocation(int index,
      {required bool Function(int) validator,
      required int Function(int) transform}) async {
    return await FirebaseFirestore.instance
        .runTransaction<bool>((transaction) async {
      // Increment value
      final List<int> _values = await transaction
          .get(_collectionReference.doc('locations'))
          .then((value) =>
              (value.data()?['values'] as List<dynamic>).cast<int>());

      var _value = _values[index];

      if (!validator(_value)) {
        return false;
      }
      _value = transform(_value);
      _values[index] = _value;

      transaction
          .update(_collectionReference.doc('locations'), {'values': _values});
      return true;
    });
  }

  @override
  Future<StatsSnapshot> get stats async {
    return StatsSnapshot(
      logs: await _collectionReference
          .doc('stats')
          .collection('logs')
          .get()
          .then((value) => value.docs
              .map((snapshot) => LogEntry.fromFirebaseData(snapshot.data()))
              .toList()
            ..sort()),
    );
  }

  Future<void> _addStat(LogEntry logEntry) async {
    _collectionReference
        .doc('stats')
        .collection('logs')
        .add(logEntry.toFirebaseData);
  }
}

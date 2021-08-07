import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:people_counter/model/log_entry.dart';

import 'room_connection.dart';

/// Database implementation using Firebase
class FirebaseRoomConnection implements RoomConnection {
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
    _locations ??= (await _collectionReference.doc('locations').get())
        .get('names')
        .toList();
    return _locations!;
  }

  @override
  Future<String> get title async {
    _title ??= (await _collectionReference.doc('meta').get()).get('title');
    return _title!;
  }

  @override
  Stream<List<int>> get valuesStream {
    _valuesStream ??= _collectionReference
        .doc('locations')
        .snapshots()
        .map<List<int>>((snapshot) => snapshot.get('values'));
    return _valuesStream!;
  }

  Stream<int> get totalStream =>
      valuesStream.map((list) => list.fold(0, (a, b) => a + b));

  @override
  Future<void> incrementLocation(int index) =>
      _updateLocation(index, (i) => i++);

  @override
  Future<void> decrementLocation(int index) => _updateLocation(index, (i) {
        i--;
        if (i < 0) return 0;
        return i;
      });

  @override
  Future<void> resetLocation(int index) => _updateLocation(index, (i) => 0);

  Future<void> _updateLocation(int index, Function(int) transform) =>
      FirebaseFirestore.instance.runTransaction((transaction) async {
        // Increment value
        final _valuesRef = _collectionReference.doc('locations');
        final _values =
            (await transaction.get(_valuesRef)).get('values') as List<int>;

        _values[index] = transform(_values[index]);

        transaction.update(_valuesRef, {'values': _values});
      });

  Future<List<LogEntry>> get stats async {
    return (await _collectionReference.doc('stats').collection('logs').get())
        .docs
        .map((snapshot) => LogEntry())
        .toList();
  }

  Future<void> addStat(LogEntry logEntry) async {}

  Future<void> resetStats() async {}

  Future<void> resetAll() async {}
}

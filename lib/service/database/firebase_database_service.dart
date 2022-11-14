import 'dart:async';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:people_counter/model/database/room_info.dart';

import '../../model/log_entry.dart';
import '../../model/database/stats_snapshot.dart';
import 'database_service.dart';

class FirebaseDatabaseService implements DatabaseService {
  @override
  Future<EventConnection> getEventByCode(String code) async =>
      FirebaseEventConnection(code);
}

class FirebaseEventConnection implements EventConnection {
  static const String _defaultTitle = 'Event Name Not Found';

  @override
  final String code;

  late final CollectionReference<Map<String, dynamic>> _collectionReference;

  Future<String>? _name;

  FirebaseEventConnection(this.code) {
    // Sets the reference to collection at root/{room name}
    _collectionReference = FirebaseFirestore.instance.collection(code);
  }

  @override
  Future<String> get name {
    _name ??= _collectionReference
        .doc('meta')
        .get()
        .then((value) => value.data()?['name'] as String? ?? _defaultTitle);
    return _name!;
  }

  @override
  Future<List<LocationConnection>> get locations async {
    final _names = await _collectionReference.doc('locations').get().then(
        (value) =>
            (value.data()?['names'] as List<dynamic>?)?.cast<String>() ?? []);

    _valuesStream ??= _collectionReference
        .doc('locations')
        .snapshots()
        .map<List<int>>((snapshot) =>
            (snapshot.data()?['values'] as List<dynamic>).cast<int>());
  }
}

class FirebaseLocationConnection implements LocationConnection {
  final int index;

  @override
  Future<void> sendIncrement() async {
    await _updateLocation(index,
        validator: (i) => true, transform: (i) => i + 1);
    await _addStat(LogEntry.entry(location: index));
  }

  @override
  Future<void> sendDecrement() async {
    if (await _updateLocation(
      index,
      validator: (i) => i > 0,
      transform: (i) => i - 1,
    )) {
      await _addStat(LogEntry.exit(location: index));
    }
  }

  @override
  Future<void> sendReset() async {
    if (await _updateLocation(
      index,
      validator: (i) => i > 0,
      transform: (i) => 0,
    )) {
      await _addStat(LogEntry.reset(location: index));
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

  Future<void> _addStat(LogEntry logEntry) async {
    _collectionReference
        .doc('stats')
        .collection('logs')
        .add(logEntry.toFirebaseData);
  }
}

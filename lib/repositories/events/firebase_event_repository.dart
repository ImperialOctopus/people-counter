import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';
import '../../models/log_entry.dart';
import 'events_repository.dart';

class FirebaseEventsRepository implements EventsRepository {
  const FirebaseEventsRepository._();

  static Future<FirebaseEventsRepository> initialise() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    return const FirebaseEventsRepository._();
  }

  @override
  Future<EventConnection?> getEventByCode(String code) async =>
      FirebaseEventConnection.initialise(code);
}

class FirebaseEventConnection implements EventConnection {
  final CollectionReference<Map<String, dynamic>> _collectionReference;

  final String _name;

  @override
  final String code;

  const FirebaseEventConnection._(
    this.code,
    this._collectionReference,
    this._name,
  );

  static Future<FirebaseEventConnection?> initialise(String code) async {
    // Sets the reference to collection at root/{room name}
    final collectionReference = FirebaseFirestore.instance.collection(code);

    final name = await collectionReference
        .doc('meta')
        .get()
        .then((value) => value.data()?['name'] as String?);

    if (name == null) {
      return null;
    }

    return FirebaseEventConnection._(code, collectionReference, name);
  }

  @override
  String get name => _name;

  @override
  Future<List<Future<LocationConnection>>> get locations async {
    final names = await _collectionReference.doc('locations').get().then(
        (value) =>
            (value.data()?['names'] as List<dynamic>?)?.cast<String>() ??
            <String>[]);

    final valuesStream = _collectionReference
        .doc('locations')
        .snapshots()
        .map<List<int>>((snapshot) =>
            (snapshot.data()?['values'] as List<dynamic>).cast<int>());

    return names.asMap().entries.map((entry) {
      final index = entry.key;
      final name = entry.value;
      final singleStream = valuesStream.map((values) => values[index]);
      return FirebaseLocationConnection.initialise(
          _collectionReference, name, index, singleStream);
    }).toList();
  }
}

class FirebaseLocationConnection implements LocationConnection {
  final CollectionReference<Map<String, dynamic>> _collectionReference;

  final String _name;

  final int _index;

  @override
  final Stream<int> valuesStream;

  @override
  String get name => _name;

  const FirebaseLocationConnection._(
      this._collectionReference, this._name, this._index, this.valuesStream);

  static Future<LocationConnection> initialise(
    CollectionReference<Map<String, dynamic>> collectionReference,
    String name,
    int index,
    Stream<int> valuesStream,
  ) async {
    return FirebaseLocationConnection._(
        collectionReference, name, index, valuesStream);
  }

  @override
  Future<void> sendIncrement() async {
    await _updateLocation(_index,
        validator: (i) => true, transform: (i) => i + 1);
    await _addStat(LogEntry.entry(location: _index));
  }

  @override
  Future<void> sendDecrement() async {
    if (await _updateLocation(
      _index,
      validator: (i) => i > 0,
      transform: (i) => i - 1,
    )) {
      await _addStat(LogEntry.exit(location: _index));
    }
  }

  @override
  Future<void> sendReset() async {
    if (await _updateLocation(
      _index,
      validator: (i) => i > 0,
      transform: (i) => 0,
    )) {
      await _addStat(LogEntry.reset(location: _index));
    }
  }

  Future<bool> _updateLocation(int index,
      {required bool Function(int) validator,
      required int Function(int) transform}) async {
    return await FirebaseFirestore.instance
        .runTransaction<bool>((transaction) async {
      // Increment value
      final List<int> values = await transaction
          .get(_collectionReference.doc('locations'))
          .then((value) =>
              (value.data()?['values'] as List<dynamic>).cast<int>());

      var value = values[index];

      if (!validator(value)) {
        return false;
      }
      value = transform(value);
      values[index] = value;

      transaction
          .update(_collectionReference.doc('locations'), {'values': values});
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

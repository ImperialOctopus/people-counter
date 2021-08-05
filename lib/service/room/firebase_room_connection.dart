import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/stats_snapshot.dart';
import 'room_connection.dart';

/// Database implementation using Firebase
class FirebaseRoomConnection implements RoomConnection {
  static const String defaultRoomTitle = 'People Counter Room';

  static const String roomNamesRef = 'names';
  static const String valuesRef = 'values';
  static const String statsRef = 'stats';

  static const String metaRef = 'meta';
  static const String metaRefName = 'name';

  final String roomName;

  late final CollectionReference<Map<String, dynamic>> _collectionReference;

  FirebaseRoomConnection(this.roomName) {
    // Sets the reference to collection at root/{room name}
    _collectionReference = FirebaseFirestore.instance.collection(roomName);
  }

  /// Static information
  @override
  Future<List<String>> get locations async {
    return (await _collectionReference.doc(roomNamesRef).get())
            .data()
            ?.values
            .map((e) => e.toString())
            .toList() ??
        [];
  }

  @override
  Future<String> get title async {
    return (await _collectionReference.doc(metaRef).get())
            .data()?[metaRefName]
            ?.toString() ??
        defaultRoomTitle;
  }

  @override
  Future<void> incrementLocation(int index) {
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      //// Reads
      // Location value
      final roomDoc = _collectionReference.doc(valuesRef);
      final currentValue =
          (await transaction.get(roomDoc)).data()?[index.toString()];

      // Total value
      final statsDoc = _collectionReference.doc(statsRef);
      final currentTotal = (await transaction.get(statsDoc)).data()?['total'];

      //// Writes
      transaction.update(roomDoc, {index.toString(): currentValue + 1});
      transaction.update(statsDoc, {'total': currentTotal + 1});
    });
  }

  @override
  Future<void> decrementLocation(int index) {
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      //// Reads
      // Increment value
      final roomDoc = _collectionReference.doc(valuesRef);
      final currentValue =
          (await transaction.get(roomDoc)).data()?[index.toString()];
      int newValue = currentValue - 1;
      if (newValue < 0) newValue = 0;

      //// Writes
      transaction.update(roomDoc, {index.toString(): newValue});
    });
  }

  @override
  Future<void> resetLocation(int index) {
    return _collectionReference.doc(valuesRef).update({
      index.toString(): 0,
    });
  }

  @override
  Future<void> resetStats() {
    return _collectionReference.doc(statsRef).update({
      'total': 0,
    });
  }

  @override
  Stream<List<int>> get valuesStream =>
      _collectionReference.doc(valuesRef).snapshots().map<List<int>>((doc) {
        return doc
                .data()
                ?.values
                .map((e) => int.parse(e.toString()))
                .toList() ??
            [];
      });

  @override
  Stream<StatsSnapshot> get statsStream =>
      _collectionReference.doc(statsRef).snapshots().map<StatsSnapshot>((doc) {
        final data = doc.data();
        return StatsSnapshot(
          totalEntries: data?['total'] ?? 0,
        );
      });
}

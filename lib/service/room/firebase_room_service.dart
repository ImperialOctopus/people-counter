import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'room_service.dart';

/// Database implementation using Firebase
class FirebaseRoomService implements RoomService {
  static const String roomNamesRef = 'names';
  static const String valuesRef = 'values';

  static const String metaRef = 'meta';
  static const String metaRefName = 'name';

  final String roomName;

  CollectionReference _collectionReference;

  FirebaseRoomService(this.roomName) {
    _collectionReference = FirebaseFirestore.instance.collection(roomName);
  }

  @override
  Future<List<String>> get placeNames async {
    return (await _collectionReference.doc(roomNamesRef).get())
        .data()
        .values
        .map((e) => e.toString())
        .toList();
  }

  @override
  Future<String> get roomTitle async {
    return (await _collectionReference.doc(metaRef)?.get())
        ?.data()[metaRefName]
        ?.toString();
  }

  @override
  Future<void> modifyValue(int index, int change) {
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      final documentReference = _collectionReference.doc(valuesRef);
      final snapshot = await transaction.get(documentReference);

      int newValue = snapshot.data()[index.toString()] + change;
      if (newValue < 0) {
        newValue = 0;
      }

      // Perform an update on the document
      transaction.update(documentReference, {index.toString(): newValue});
    });
  }

  @override
  Future<void> setValue(int index, int value) {
    return _collectionReference
        .doc(valuesRef)
        .update({index.toString(): value});
  }

  @override
  Stream<List<int>> get valueStream =>
      _collectionReference.doc(valuesRef).snapshots().map<List<int>>((doc) {
        return doc.data().values.map((e) => int.parse(e.toString())).toList();
      });
}

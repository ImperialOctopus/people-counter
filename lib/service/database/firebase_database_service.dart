import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_service.dart';

/// Database implementation using Firebase
class FirebaseDatabaseService implements DatabaseService {
  DocumentReference _documentReference;

  FirebaseDatabaseService() {
    _documentReference =
        FirebaseFirestore.instance.collection('counter').doc('tt_christmas');
  }

  @override
  Future<void> modifyValue(int index, int change) {
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(_documentReference);

      int newValue = snapshot.data()[index] + change;
      if (newValue < 0) {
        newValue = 0;
      }

      // Perform an update on the document
      transaction.update(_documentReference, {index.toString(): newValue});
    });
  }

  @override
  Future<void> setValue(int index, int value) {
    return _documentReference.update({index.toString(): value});
  }

  @override
  Stream<Map<int, int>> get valueStream =>
      _documentReference.snapshots().map((doc) => {
            0: doc.data()[0],
            1: doc.data()[1],
            2: doc.data()[2],
            3: doc.data()[3],
          });
}

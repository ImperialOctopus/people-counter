import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_service.dart';

/// Database implementation using Firebase
class FirebaseDatabaseService implements DatabaseService {
  DocumentReference _documentReference;
  Stream<int> _stream;

  FirebaseDatabaseService() {
    _documentReference =
        FirebaseFirestore.instance.collection('counter').doc('tt_christmas');
    _stream =
        _documentReference.snapshots().map((doc) => doc.data()['value'] as int);
    _documentReference.snapshots().listen((event) {
      print(event['value']);
    });
  }

  @override
  Future<void> modifyValue(int change) {
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(_documentReference);

      int newValue = snapshot.data()['value'] + change;
      if (newValue < 0) {
        newValue = 0;
      }

      // Perform an update on the document
      transaction.update(_documentReference, {'value': newValue});
    });
  }

  @override
  Future<void> setValue(int value) {
    return _documentReference.update({'value': value});
  }

  @override
  Stream<int> get valueStream => _stream;
}

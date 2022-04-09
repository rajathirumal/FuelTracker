// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_tracker/models/analysis.dart';
import 'package:fuel_tracker/models/fuel.dart';

class FireStoreService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> saveFuelToFirestore(FuelData fuelData) {
    return db.collection("fuels").doc(fuelData.fuelID).set(fuelData.toMap());
  }

  Stream<List<FuelData>> getAllFuelsFromFireStore() {
    return db
        .collection("fuels")
        .orderBy("dateOfFuel", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((document) => FuelData.fromMap(document.data()))
              .toList(),
        );
  }

  Future<void> addAnalysisToFireStore(Analysis newData) {
    return db.collection("analysis").doc("current").set(newData.toMap());
  }
}

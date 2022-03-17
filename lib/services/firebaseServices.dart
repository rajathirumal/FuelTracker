import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_tracker/models/fuel.dart';

class FireStoreService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> saveFuelToFirestore(FuelData fuelData) {
    return db.collection("fuels").doc(fuelData.fuelID).set(fuelData.toMap());
  }

  Stream<List<FuelData>> getAllFuelsFromFireStore() {
    return db.collection("fuels").snapshots().map(
          (snapshot) => snapshot.docs
              .map((document) => FuelData.fromMap(document.data()))
              .toList(),
        );
  }
}

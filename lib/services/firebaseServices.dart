import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_tracker/models/fuel.dart';

class FireStoreService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> saveFuelToFirestore(FuelData fuelData) {
    return db.collection("fuels").doc(fuelData.fuelID).set(fuelData.toMap());
  }
}

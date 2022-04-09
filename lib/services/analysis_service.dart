import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_tracker/models/analysis.dart';
import 'package:fuel_tracker/models/fuel.dart';
import 'package:fuel_tracker/services/firebaseServices.dart';

class AnalysisService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FireStoreService _fireStoreService = FireStoreService();

  Future<dynamic> calculate(List<FuelData>? allFuel) async {
    if (allFuel == null) {
    } else {
      double haveSaved = 0.0;
      double moneySpent = 0.0;

      for (FuelData fuel in allFuel) {
        haveSaved += fuel.remainingKM;
        moneySpent += fuel.fueledForPrice;
      }

      _fireStoreService.addAnalysisToFireStore(
        Analysis(
          couldHaveSaved: haveSaved,
          lastUpdate: DateTime.now().toString(),
          refuelCount: allFuel.length,
          totalMoneySpent: moneySpent,
        ),
      );
    }

    return await db.collection('analysis').doc('current').get();
  }
}

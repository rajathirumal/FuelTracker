import 'package:flutter/material.dart';
import 'package:fuel_tracker/models/fuel.dart';
import 'package:fuel_tracker/services/firebaseServices.dart';
import 'package:uuid/uuid.dart';

class FuelProvider with ChangeNotifier {
  final _fireSS = FireStoreService();
  String _fuelID = "";
  double _fueledForPrice = 0.0;
  double _marketpricePerLiter = 0.0;
  double _atKm = 0.0;
  double _remainingKM = 0.0;
  var uuid = Uuid();

  double get fueledForPrice => _fueledForPrice;
  double get marketPrice => _marketpricePerLiter;
  double get atKm => _atKm;
  double get remainingKm => _remainingKM;

  changeFuelForPrice(String value) {
    _fueledForPrice = double.parse(value);
    notifyListeners();
  }

  changemarketPrice(String value) {
    _marketpricePerLiter = double.parse(value);
    notifyListeners();
  }

  changeAtKm(String value) {
    _atKm = double.parse(value);
    notifyListeners();
  }

  changeRemainingKm(String value) {
    _remainingKM = double.parse(value);
    notifyListeners();
  }

  saveFuelToFireStore() {
    var fuel = FuelData(
      fuelID: uuid.v4(),
      fueledForPrice: _fueledForPrice,
      marketpricePerLiter: _marketpricePerLiter,
      atKm: _atKm,
      remainingKM: _remainingKM,
    );
    _fireSS.saveFuelToFirestore(fuel);
  }

  removeFuelFromFireStore() {}
}

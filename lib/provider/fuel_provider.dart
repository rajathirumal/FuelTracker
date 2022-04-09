import 'package:flutter/material.dart';
import 'package:fuel_tracker/models/fuel.dart';
import 'package:fuel_tracker/services/firebaseServices.dart';
import 'package:uuid/uuid.dart';

class FuelProvider with ChangeNotifier {
  final _fireSS = FireStoreService();
  double _fueledForPrice = 0.0;
  double _marketpricePerLiter = 0.0;
  double _atKm = 0.0;
  double _remainingKM = 0.0;
  var uuid = const Uuid();

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

  saveFuelToFireStore(
      {required fuelID,
      required fuelforprice,
      required marketprice,
      required atkms,
      required remainingkms,
      required datefueld}) {
    var newfuel = FuelData(
      fuelID: fuelID,
      fueledForPrice: double.parse(fuelforprice),
      marketpricePerLiter: double.parse(marketprice),
      atKm: double.parse(atkms),
      remainingKM: double.parse(remainingkms),
      dateOfFuel: datefueld,
    );

    _fireSS.saveFuelToFirestore(newfuel);
  }

  loadFuel(FuelData? fuel) {
    _fueledForPrice = fuel!.fueledForPrice;
    _marketpricePerLiter = fuel.marketpricePerLiter;
    _atKm = fuel.atKm;
    _remainingKM = fuel.remainingKM;
  }
}

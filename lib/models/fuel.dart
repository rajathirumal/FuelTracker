import 'dart:convert';

class FuelData {
  final String fuelID;
  final double fueledForPrice;
  final double marketpricePerLiter;
  final double atKm;
  final double remainingKM;
  final String dateOfFuel;
  FuelData({
    required this.fuelID,
    required this.fueledForPrice,
    required this.marketpricePerLiter,
    required this.atKm,
    required this.remainingKM,
    required this.dateOfFuel,
  });

  FuelData copyWith({
    String? fuelID,
    double? fueledForPrice,
    double? marketpricePerLiter,
    double? atKm,
    double? remainingKM,
    String? dateOfFuel,
  }) {
    return FuelData(
      fuelID: fuelID ?? this.fuelID,
      fueledForPrice: fueledForPrice ?? this.fueledForPrice,
      marketpricePerLiter: marketpricePerLiter ?? this.marketpricePerLiter,
      atKm: atKm ?? this.atKm,
      remainingKM: remainingKM ?? this.remainingKM,
      dateOfFuel: dateOfFuel ?? this.dateOfFuel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fuelID': fuelID,
      'fueledForPrice': fueledForPrice,
      'marketpricePerLiter': marketpricePerLiter,
      'atKm': atKm,
      'remainingKM': remainingKM,
      'dateOfFuel': dateOfFuel,
    };
  }

  factory FuelData.fromMap(Map<String, dynamic> map) {
    return FuelData(
      fuelID: map['fuelID'] ?? '',
      fueledForPrice: map['fueledForPrice']?.toDouble() ?? 0.0,
      marketpricePerLiter: map['marketpricePerLiter']?.toDouble() ?? 0.0,
      atKm: map['atKm']?.toDouble() ?? 0.0,
      remainingKM: map['remainingKM']?.toDouble() ?? 0.0,
      dateOfFuel: map['dateOfFuel'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FuelData.fromJson(String source) =>
      FuelData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FuelData(fuelID: $fuelID, fueledForPrice: $fueledForPrice, marketpricePerLiter: $marketpricePerLiter, atKm: $atKm, remainingKM: $remainingKM, dateOfFuel: $dateOfFuel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FuelData &&
        other.fuelID == fuelID &&
        other.fueledForPrice == fueledForPrice &&
        other.marketpricePerLiter == marketpricePerLiter &&
        other.atKm == atKm &&
        other.remainingKM == remainingKM &&
        other.dateOfFuel == dateOfFuel;
  }

  @override
  int get hashCode {
    return fuelID.hashCode ^
        fueledForPrice.hashCode ^
        marketpricePerLiter.hashCode ^
        atKm.hashCode ^
        remainingKM.hashCode ^
        dateOfFuel.hashCode;
  }
}

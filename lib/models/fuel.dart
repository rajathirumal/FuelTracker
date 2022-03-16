import 'dart:convert';

class FuelData {
  final String fuelID;
  final double fueledForPrice;
  final double marketpricePerLiter;
  final double atKm;
  final double remainingKM;
  FuelData({
    required this.fuelID,
    required this.fueledForPrice,
    required this.marketpricePerLiter,
    required this.atKm,
    required this.remainingKM,
  });

  FuelData copyWith({
    String? fuelID,
    double? fueledForPrice,
    double? marketpricePerLiter,
    double? atKm,
    double? remainingKM,
  }) {
    return FuelData(
      fuelID: fuelID ?? this.fuelID,
      fueledForPrice: fueledForPrice ?? this.fueledForPrice,
      marketpricePerLiter: marketpricePerLiter ?? this.marketpricePerLiter,
      atKm: atKm ?? this.atKm,
      remainingKM: remainingKM ?? this.remainingKM,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fuelID': fuelID,
      'fueledForPrice': fueledForPrice,
      'marketpricePerLiter': marketpricePerLiter,
      'atKm': atKm,
      'remainingKM': remainingKM,
    };
  }

  factory FuelData.fromMap(Map<String, dynamic> map) {
    return FuelData(
      fuelID: map['fuelID'] ?? '',
      fueledForPrice: map['fueledForPrice']?.toDouble() ?? 0.0,
      marketpricePerLiter: map['marketpricePerLiter']?.toDouble() ?? 0.0,
      atKm: map['atKm']?.toDouble() ?? 0.0,
      remainingKM: map['remainingKM']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FuelData.fromJson(String source) =>
      FuelData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FuelData(fuelID: $fuelID, fueledForPrice: $fueledForPrice, marketpricePerLiter: $marketpricePerLiter, atKm: $atKm, remainingKM: $remainingKM)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FuelData &&
        other.fuelID == fuelID &&
        other.fueledForPrice == fueledForPrice &&
        other.marketpricePerLiter == marketpricePerLiter &&
        other.atKm == atKm &&
        other.remainingKM == remainingKM;
  }

  @override
  int get hashCode {
    return fuelID.hashCode ^
        fueledForPrice.hashCode ^
        marketpricePerLiter.hashCode ^
        atKm.hashCode ^
        remainingKM.hashCode;
  }
}

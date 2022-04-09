import 'dart:convert';

class Analysis {
  double couldHaveSaved;
  String lastUpdate;
  int refuelCount;
  double totalMoneySpent;
  Analysis({
    required this.couldHaveSaved,
    required this.lastUpdate,
    required this.refuelCount,
    required this.totalMoneySpent,
  });

  Analysis copyWith({
    double? couldHaveSaved,
    String? lastUpdate,
    int? refuelCount,
    double? totalMoneySpent,
  }) {
    return Analysis(
      couldHaveSaved: couldHaveSaved ?? this.couldHaveSaved,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      refuelCount: refuelCount ?? this.refuelCount,
      totalMoneySpent: totalMoneySpent ?? this.totalMoneySpent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'couldHaveSaved': couldHaveSaved,
      'lastUpdate': lastUpdate,
      'refuelCount': refuelCount,
      'totalMoneySpent': totalMoneySpent,
    };
  }

  factory Analysis.fromMap(Map<String, dynamic> map) {
    return Analysis(
      couldHaveSaved: map['couldHaveSaved']?.toDouble() ?? 0.0,
      lastUpdate: map['lastUpdate'] ?? '',
      refuelCount: map['refuelCount']?.toInt() ?? 0,
      totalMoneySpent: map['totalMoneySpent']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Analysis.fromJson(String source) =>
      Analysis.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Analysis(couldHaveSaved: $couldHaveSaved, lastUpdate: $lastUpdate, refuelCount: $refuelCount, totalMoneySpent: $totalMoneySpent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Analysis &&
        other.couldHaveSaved == couldHaveSaved &&
        other.lastUpdate == lastUpdate &&
        other.refuelCount == refuelCount &&
        other.totalMoneySpent == totalMoneySpent;
  }

  @override
  int get hashCode {
    return couldHaveSaved.hashCode ^
        lastUpdate.hashCode ^
        refuelCount.hashCode ^
        totalMoneySpent.hashCode;
  }
}

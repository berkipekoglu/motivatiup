import 'dart:convert';

class MotivationQuotes {
  int id;
  String motivasyonSozu;
  String motivasyonSozuSahibi;

  MotivationQuotes({
    this.id,
    this.motivasyonSozu,
    this.motivasyonSozuSahibi,
  });

  MotivationQuotes.withID({
    this.id,
    this.motivasyonSozu,
    this.motivasyonSozuSahibi,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'motivasyonSozu': motivasyonSozu,
      'motivasyonSozuSahibi': motivasyonSozuSahibi,
    };
  }

  factory MotivationQuotes.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MotivationQuotes(
      id: map['id'],
      motivasyonSozu: map['motivasyonSozu'],
      motivasyonSozuSahibi: map['motivasyonSozuSahibi'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MotivationQuotes.fromJson(String source) =>
      MotivationQuotes.fromMap(json.decode(source));

  @override
  String toString() =>
      'MotivationQuotes(id: $id, motivasyonSozu: $motivasyonSozu, motivasyonSozuSahibi: $motivasyonSozuSahibi)';

  MotivationQuotes copyWith({
    int id,
    String motivasyonSozu,
    String motivasyonSozuSahibi,
  }) {
    return MotivationQuotes(
      id: id ?? this.id,
      motivasyonSozu: motivasyonSozu ?? this.motivasyonSozu,
      motivasyonSozuSahibi: motivasyonSozuSahibi ?? this.motivasyonSozuSahibi,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MotivationQuotes &&
        o.id == id &&
        o.motivasyonSozu == motivasyonSozu &&
        o.motivasyonSozuSahibi == motivasyonSozuSahibi;
  }

  @override
  int get hashCode =>
      id.hashCode ^ motivasyonSozu.hashCode ^ motivasyonSozuSahibi.hashCode;
}

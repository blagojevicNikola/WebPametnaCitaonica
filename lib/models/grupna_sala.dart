import 'package:json_annotation/json_annotation.dart';

import 'clanarina.dart';
import 'karakteristike_sale.dart';

part 'grupna_sala.g.dart';

@JsonSerializable()
class GrupnaSala {
  int? id;
  @JsonKey(name: 'brojSale')
  String naziv;
  @JsonKey(name: 'kod')
  String qrKod;
  @JsonKey(name: 'kapacitet')
  int brojMjesta;
  String? opis;
  int statusId;
  Clanarina? clanarine;
  KarakteristikeSale? karakteristikeSale;

  GrupnaSala(
      {this.id,
      required this.naziv,
      required this.qrKod,
      required this.brojMjesta,
      this.opis,
      required this.statusId,
      this.clanarine,
      this.karakteristikeSale});

  factory GrupnaSala.fromJson(Map<String, dynamic> json) =>
      _$GrupnaSalaFromJson(json);
  Map<String, dynamic> toJson() => _$GrupnaSalaToJson(this);
}

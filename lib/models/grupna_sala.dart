import 'package:json_annotation/json_annotation.dart';

part 'grupna_sala.g.dart';

@JsonSerializable()
class GrupnaSala {
  int? id;
  String naziv;
  @JsonKey(name: 'qr_kod')
  String qrKod;
  @JsonKey(name: 'broj_mjesta')
  int brojMjesta;
  bool tv;
  bool klima;
  bool projektor;

  GrupnaSala(
      {this.id,
      required this.naziv,
      required this.qrKod,
      required this.brojMjesta,
      required this.tv,
      required this.klima,
      required this.projektor});

  factory GrupnaSala.fromJson(Map<String, dynamic> json) =>
      _$GrupnaSalaFromJson(json);
  Map<String, dynamic> toJson() => _$GrupnaSalaToJson(this);
}

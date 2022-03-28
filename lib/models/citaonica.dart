import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

import 'dan.dart';
import 'grupna_sala.dart';
import 'individualna_sala.dart';
import 'radno_vrijeme.dart';

part 'citaonica.g.dart';

@JsonSerializable()
class Citaonica {
  int? id;
  String name;
  String mail;
  @JsonKey(name: 'phone_number')
  String phoneNumber;
  String adresa;
  @JsonKey(name: 'radno_vrijeme')
  List<RadnoVrijemeUDanu> radnoVrijeme;
  //String? vlasnik;
  @JsonKey(name: 'slika_url')
  String? slikaURL;

  @JsonKey(name: 'individualne_sale')
  final List<IndividualnaSala> individualneSale;
  @JsonKey(name: 'grupne_sale')
  final List<GrupnaSala> grupneSale;

  Citaonica(
      {required this.name,
      required this.mail,
      required this.phoneNumber,
      required this.adresa,
      required this.radnoVrijeme,
      required this.individualneSale,
      required this.grupneSale,
      this.id});

  void dodajIndividualnuSalu(IndividualnaSala sala) {
    individualneSale.add(sala);
  }

  void obrisiIndividualnuSalu(int index) {
    individualneSale.removeAt(index);
  }

  factory Citaonica.fromJson(Map<String, dynamic> json) =>
      _$CitaonicaFromJson(json);
  Map<String, dynamic> toJson() => _$CitaonicaToJson(this);
}

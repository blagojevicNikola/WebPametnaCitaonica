import 'package:json_annotation/json_annotation.dart';

import 'radno_vrijeme.dart';

part 'citaonica.g.dart';

@JsonSerializable()
class Citaonica {
  int? id;
  @JsonKey(name: 'naziv')
  String name;
  String mail;
  @JsonKey(name: 'brojTelefona')
  String phoneNumber;
  String adresa;
  @JsonKey(name: 'radnoVrijeme')
  List<RadnoVrijemeUDanu> radnoVrijeme;
  String vlasnik;
  String? opis;
  int? administratorId;

  Citaonica(
      {required this.name,
      required this.mail,
      required this.phoneNumber,
      required this.adresa,
      this.opis,
      this.administratorId,
      required this.radnoVrijeme,
      required this.vlasnik,
      this.id});

  factory Citaonica.fromJson(Map<String, dynamic> json) =>
      _$CitaonicaFromJson(json);
  Map<String, dynamic> toJson() => _$CitaonicaToJson(this);
}

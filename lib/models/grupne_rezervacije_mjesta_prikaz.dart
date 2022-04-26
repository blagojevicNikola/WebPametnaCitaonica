import 'package:json_annotation/json_annotation.dart';

part 'grupne_rezervacije_mjesta_prikaz.g.dart';

@JsonSerializable()
class GrupneRezervacijeSalePrikaz {
  int id;
  DateTime vrijemeVazenjaOd;
  DateTime vrijemeVazenjaDo;
  DateTime vrijemeRezervacije;
  DateTime? vrijemePotvrde;
  DateTime? vrijemeOtkazivanja;
  int korisnikId;
  int salaId;
  String salaOznakaSale;
  String salaCitaonicaNaziv;
  String korisnikKorisnickoIme;
  String korisnikMail;

  GrupneRezervacijeSalePrikaz(
      {required this.id,
      required this.vrijemeVazenjaOd,
      required this.vrijemeVazenjaDo,
      required this.vrijemeRezervacije,
      required this.vrijemePotvrde,
      required this.vrijemeOtkazivanja,
      required this.korisnikId,
      required this.salaId,
      required this.salaOznakaSale,
      required this.salaCitaonicaNaziv,
      required this.korisnikKorisnickoIme,
      required this.korisnikMail});

  factory GrupneRezervacijeSalePrikaz.fromJson(Map<String, dynamic> json) =>
      _$GrupneRezervacijeMjestaPrikazFromJson(json);
  Map<String, dynamic> toJson() => _$GrupneRezervacijeMjestaPrikazToJson(this);
}

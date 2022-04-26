import 'package:json_annotation/json_annotation.dart';

part 'individualne_rezervacije_mjesta_prikaz.g.dart';

@JsonSerializable()
class IndividualneRezervacijeMjestaPrikaz {
  int id;
  DateTime vrijemeVazenjaOd;
  DateTime vrijemeVazenjaDo;
  DateTime vrijemeRezervacije;
  DateTime? vrijemePotvrde;
  DateTime? vrijemeOtkazivanja;
  int korisnikId;
  int mjestoId;
  int mjestoBrojMjesta;
  String mjestoSalaOznakaSale;
  String mjestoSalaCitaonicaNaziv;
  String korisnikKorisnickoIme;
  String korisnikMail;

  IndividualneRezervacijeMjestaPrikaz(
      {required this.id,
      required this.vrijemeVazenjaOd,
      required this.vrijemeVazenjaDo,
      required this.vrijemeRezervacije,
      required this.vrijemePotvrde,
      required this.vrijemeOtkazivanja,
      required this.korisnikId,
      required this.mjestoId,
      required this.mjestoBrojMjesta,
      required this.mjestoSalaOznakaSale,
      required this.mjestoSalaCitaonicaNaziv,
      required this.korisnikKorisnickoIme,
      required this.korisnikMail});

  factory IndividualneRezervacijeMjestaPrikaz.fromJson(
          Map<String, dynamic> json) =>
      _$IndividualneRezervacijeMjestaPrikazFromJson(json);
  Map<String, dynamic> toJson() =>
      _$IndividualneRezervacijeMjestaPrikazToJson(this);
}

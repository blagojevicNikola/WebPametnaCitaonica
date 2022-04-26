// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individualne_rezervacije_mjesta_prikaz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndividualneRezervacijeMjestaPrikaz
    _$IndividualneRezervacijeMjestaPrikazFromJson(Map<String, dynamic> json) =>
        IndividualneRezervacijeMjestaPrikaz(
          id: json['id'] as int,
          vrijemeVazenjaOd: DateTime.parse(json['vrijemeVazenjaOd'] as String),
          vrijemeVazenjaDo: DateTime.parse(json['vrijemeVazenjaDo'] as String),
          vrijemeRezervacije:
              DateTime.parse(json['vrijemeRezervacije'] as String),
          vrijemePotvrde: json['vrijemePotvrde'] == null
              ? null
              : DateTime.parse(json['vrijemePotvrde'] as String),
          vrijemeOtkazivanja: json['vrijemeOtkazivanja'] == null
              ? null
              : DateTime.parse(json['vrijemeOtkazivanja'] as String),
          korisnikId: json['korisnikId'] as int,
          mjestoId: json['mjestoId'] as int,
          mjestoBrojMjesta: json['mjestoBrojMjesta'] as int,
          mjestoSalaOznakaSale: json['mjestoSalaOznakaSale'] as String,
          mjestoSalaCitaonicaNaziv: json['mjestoSalaCitaonicaNaziv'] as String,
          korisnikKorisnickoIme: json['korisnikKorisnickoIme'] as String,
          korisnikMail: json['korisnikMail'] as String,
        );

Map<String, dynamic> _$IndividualneRezervacijeMjestaPrikazToJson(
        IndividualneRezervacijeMjestaPrikaz instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vrijemeVazenjaOd': instance.vrijemeVazenjaOd.toIso8601String(),
      'vrijemeVazenjaDo': instance.vrijemeVazenjaDo.toIso8601String(),
      'vrijemeRezervacije': instance.vrijemeRezervacije.toIso8601String(),
      'vrijemePotvrde': instance.vrijemePotvrde?.toIso8601String(),
      'vrijemeOtkazivanja': instance.vrijemeOtkazivanja?.toIso8601String(),
      'korisnikId': instance.korisnikId,
      'mjestoId': instance.mjestoId,
      'mjestoBrojMjesta': instance.mjestoBrojMjesta,
      'mjestoSalaOznakaSale': instance.mjestoSalaOznakaSale,
      'mjestoSalaCitaonicaNaziv': instance.mjestoSalaCitaonicaNaziv,
      'korisnikKorisnickoIme': instance.korisnikKorisnickoIme,
      'korisnikMail': instance.korisnikMail,
    };

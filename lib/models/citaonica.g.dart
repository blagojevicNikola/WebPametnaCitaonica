// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'citaonica.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Citaonica _$CitaonicaFromJson(Map<String, dynamic> json) => Citaonica(
      name: json['name'] as String,
      mail: json['mail'] as String,
      phoneNumber: json['phone_number'] as String,
      adresa: json['adresa'] as String,
      radnoVrijeme: (json['radno_vrijeme'] as List<dynamic>)
          .map((e) => RadnoVrijemeUDanu.fromJson(e as Map<String, dynamic>))
          .toList(),
      individualneSale: (json['individualne_sale'] as List<dynamic>)
          .map((e) => IndividualnaSala.fromJson(e as Map<String, dynamic>))
          .toList(),
      grupneSale: (json['grupne_sale'] as List<dynamic>)
          .map((e) => GrupnaSala.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
    )..slikaURL = json['slika_url'] as String?;

Map<String, dynamic> _$CitaonicaToJson(Citaonica instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mail': instance.mail,
      'phone_number': instance.phoneNumber,
      'adresa': instance.adresa,
      'radno_vrijeme': instance.radnoVrijeme,
      'slika_url': instance.slikaURL,
      'individualne_sale': instance.individualneSale,
      'grupne_sale': instance.grupneSale,
    };

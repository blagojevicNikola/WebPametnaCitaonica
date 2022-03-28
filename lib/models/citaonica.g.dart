// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'citaonica.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Citaonica _$CitaonicaFromJson(Map<String, dynamic> json) => Citaonica(
      name: json['naziv'] as String,
      mail: json['mail'] as String,
      phoneNumber: json['brojTelefona'] as String,
      adresa: json['adresa'] as String,
      radnoVrijeme: (json['radnoVrijeme'] as List<dynamic>)
          .map((e) => RadnoVrijemeUDanu.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
    )
      ..opis = json['opis'] as String?
      ..administratorId = json['administratorId'] as int?;

Map<String, dynamic> _$CitaonicaToJson(Citaonica instance) => <String, dynamic>{
      'id': instance.id,
      'naziv': instance.name,
      'mail': instance.mail,
      'brojTelefona': instance.phoneNumber,
      'adresa': instance.adresa,
      'radnoVrijeme': instance.radnoVrijeme,
      'opis': instance.opis,
      'administratorId': instance.administratorId,
    };

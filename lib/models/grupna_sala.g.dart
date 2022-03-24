// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grupna_sala.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrupnaSala _$GrupnaSalaFromJson(Map<String, dynamic> json) => GrupnaSala(
      id: json['id'] as int?,
      naziv: json['naziv'] as String,
      qrKod: json['qr_kod'] as String,
      brojMjesta: json['broj_mjesta'] as int,
      tv: json['tv'] as bool,
      klima: json['klima'] as bool,
      projektor: json['projektor'] as bool,
    );

Map<String, dynamic> _$GrupnaSalaToJson(GrupnaSala instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'qr_kod': instance.qrKod,
      'broj_mjesta': instance.brojMjesta,
      'tv': instance.tv,
      'klima': instance.klima,
      'projektor': instance.projektor,
    };

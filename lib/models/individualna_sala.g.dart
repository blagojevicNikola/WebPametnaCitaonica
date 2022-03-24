// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individualna_sala.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndividualnaSala _$IndividualnaSalaFromJson(Map<String, dynamic> json) =>
    IndividualnaSala(
      id: json['id'] as int?,
      naziv: json['naziv'] as String,
      listaMjesta: (json['lista_mjesta'] as List<dynamic>?)
          ?.map((e) => Mjesto.fromJson(e as Map<String, dynamic>))
          .toList(),
      slikaURL: json['slika_url'] as String,
    )..brojMjesta = json['broj_mjesta'] as int?;

Map<String, dynamic> _$IndividualnaSalaToJson(IndividualnaSala instance) =>
    <String, dynamic>{
      'id': instance.id,
      'naziv': instance.naziv,
      'broj_mjesta': instance.brojMjesta,
      'lista_mjesta': instance.listaMjesta,
      'slika_url': instance.slikaURL,
    };

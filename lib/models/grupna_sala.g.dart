// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grupna_sala.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrupnaSala _$GrupnaSalaFromJson(Map<String, dynamic> json) => GrupnaSala(
      id: json['id'] as int?,
      naziv: json['oznakaSale'] as String,
      qrKod: json['kod'] as String,
      brojMjesta: json['kapacitet'] as int,
      opis: json['opis'] as String?,
      statusId: json['statusId'] as int,
      clanarine: (json['clanarine'] as List<dynamic>)
          .map((e) =>
              e == null ? null : Clanarina.fromJson(e as Map<String, dynamic>))
          .toList(),
      karakteristike: (json['karakteristike'] as List<dynamic>)
          .map((e) => KarakteristikeSale.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GrupnaSalaToJson(GrupnaSala instance) =>
    <String, dynamic>{
      'id': instance.id,
      'oznakaSale': instance.naziv,
      'kod': instance.qrKod,
      'kapacitet': instance.brojMjesta,
      'opis': instance.opis,
      'statusId': instance.statusId,
      'clanarine': instance.clanarine,
      'karakteristike': instance.karakteristike,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individualna_sala.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndividualnaSala _$IndividualnaSalaFromJson(Map<String, dynamic> json) =>
    IndividualnaSala(
      id: json['id'] as int?,
      naziv: json['oznakaSale'] as String,
      brojMjesta: json['kapacitet'] as int?,
      opis: json['opis'] as String?,
      clanarine: json['clanarine'] == null
          ? null
          : Clanarina.fromJson(json['clanarine'] as Map<String, dynamic>),
      karakteristikeSale: json['karakteristikeSale'] == null
          ? null
          : KarakteristikeSale.fromJson(
              json['karakteristikeSale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IndividualnaSalaToJson(IndividualnaSala instance) =>
    <String, dynamic>{
      'id': instance.id,
      'oznakaSale': instance.naziv,
      'kapacitet': instance.brojMjesta,
      'opis': instance.opis,
      'clanarine': instance.clanarine,
      'karakteristikeSale': instance.karakteristikeSale,
    };

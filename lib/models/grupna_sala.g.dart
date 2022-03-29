// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grupna_sala.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrupnaSala _$GrupnaSalaFromJson(Map<String, dynamic> json) => GrupnaSala(
      id: json['id'] as int?,
      naziv: json['brojSale'] as String,
      qrKod: json['kod'] as String,
      brojMjesta: json['kapacitet'] as int,
      opis: json['opis'] as String?,
      statusId: json['statusId'] as int,
      clanarine: json['clanarine'] == null
          ? null
          : Clanarina.fromJson(json['clanarine'] as Map<String, dynamic>),
      karakteristikeSale: json['karakteristikeSale'] == null
          ? null
          : KarakteristikeSale.fromJson(
              json['karakteristikeSale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GrupnaSalaToJson(GrupnaSala instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brojSale': instance.naziv,
      'kod': instance.qrKod,
      'kapacitet': instance.brojMjesta,
      'opis': instance.opis,
      'statusId': instance.statusId,
      'clanarine': instance.clanarine,
      'karakteristikeSale': instance.karakteristikeSale,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mjesto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mjesto _$MjestoFromJson(Map<String, dynamic> json) => Mjesto(
      pozicija: PozicijaXY.fromJson(json['pozicija'] as Map<String, dynamic>),
      velicina: (json['velicina'] as num).toDouble(),
      ugao: json['ugao'] as int,
      qrCode: json['kod'] as String,
      brojMjesta: json['brojMjesta'] as int,
      dostupno: json['dostupno'] as bool,
      uticnica: json['uticnica'] as bool,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$MjestoToJson(Mjesto instance) => <String, dynamic>{
      'id': instance.id,
      'brojMjesta': instance.brojMjesta,
      'kod': instance.qrCode,
      'velicina': instance.velicina,
      'ugao': instance.ugao,
      'uticnica': instance.uticnica,
      'dostupno': instance.dostupno,
      'pozicija': instance.pozicija,
    };

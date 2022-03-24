// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mjesto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mjesto _$MjestoFromJson(Map<String, dynamic> json) => Mjesto(
      pozicija:
          const CustomOffsetConverter().fromJson(json['pozicija'] as String),
      velicina: (json['velicina'] as num).toDouble(),
      ugao: (json['ugao'] as num).toDouble(),
      qrCode: json['qr_code'] as String,
      brojMjesta: json['broj_mjesta'] as int,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$MjestoToJson(Mjesto instance) => <String, dynamic>{
      'id': instance.id,
      'broj_mjesta': instance.brojMjesta,
      'qr_code': instance.qrCode,
      'velicina': instance.velicina,
      'ugao': instance.ugao,
      'pozicija': const CustomOffsetConverter().toJson(instance.pozicija),
    };

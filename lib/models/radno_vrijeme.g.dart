// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radno_vrijeme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadnoVrijemeUDanu _$RadnoVrijemeUDanuFromJson(Map<String, dynamic> json) =>
    RadnoVrijemeUDanu()
      ..pocetak =
          const CustomTimeOfDayConverter().fromJson(json['pocetak'] as String?)
      ..kraj =
          const CustomTimeOfDayConverter().fromJson(json['kraj'] as String?);

Map<String, dynamic> _$RadnoVrijemeUDanuToJson(RadnoVrijemeUDanu instance) =>
    <String, dynamic>{
      'pocetak': const CustomTimeOfDayConverter().toJson(instance.pocetak),
      'kraj': const CustomTimeOfDayConverter().toJson(instance.kraj),
    };

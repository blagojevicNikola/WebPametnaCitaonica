// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'argumenti_prikaza_individualne_rezervacije_mjesta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArgumentiPrikazaIndividualneRezervacijeMjesta
    _$ArgumentiPrikazaIndividualneRezervacijeMjestaFromJson(
            Map<String, dynamic> json) =>
        ArgumentiPrikazaIndividualneRezervacijeMjesta(
          vrijemeVazenjaOd: DateTime.parse(json['vrijemeVazenjaOd'] as String),
          vrijemeVazenjaDo: DateTime.parse(json['vrijemeVazenjaDo'] as String),
        );

Map<String, dynamic> _$ArgumentiPrikazaIndividualneRezervacijeMjestaToJson(
        ArgumentiPrikazaIndividualneRezervacijeMjesta instance) =>
    <String, dynamic>{
      'vrijemeVazenjaOd': instance.vrijemeVazenjaOd.toIso8601String(),
      'vrijemeVazenjaDo': instance.vrijemeVazenjaDo.toIso8601String(),
    };

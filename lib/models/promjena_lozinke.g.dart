// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promjena_lozinke.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromjenaLozinke _$PromjenaLozinkeRequestFromJson(Map<String, dynamic> json) =>
    PromjenaLozinke(
      staraLozinka: json['staraLozinka'] as String,
      novaLozinka: json['novaLozinka'] as String,
    );

Map<String, dynamic> _$PromjenaLozinkeRequestToJson(PromjenaLozinke instance) =>
    <String, dynamic>{
      'staraLozinka': instance.staraLozinka,
      'novaLozinka': instance.novaLozinka,
    };

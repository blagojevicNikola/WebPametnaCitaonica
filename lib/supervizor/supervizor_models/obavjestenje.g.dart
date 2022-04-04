// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'obavjestenje.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Obavjestenje _$ObavjestenjeFromJson(Map<String, dynamic> json) => Obavjestenje(
      naslov: json['naslov'] as String,
      tekstNotifikacije: json['sadrzaj'] as String,
    )
      ..idObavjestenja = json['id'] as int?
      ..idSupervizora = json['idSupervizora'] as int?
      ..vrijemeSlanja = json['vrijeme'] == null
          ? null
          : DateTime.parse(json['vrijeme'] as String);

Map<String, dynamic> _$ObavjestenjeToJson(Obavjestenje instance) =>
    <String, dynamic>{
      'id': instance.idObavjestenja,
      'idSupervizora': instance.idSupervizora,
      'vrijeme': instance.vrijemeSlanja?.toIso8601String(),
      'naslov': instance.naslov,
      'sadrzaj': instance.tekstNotifikacije,
    };

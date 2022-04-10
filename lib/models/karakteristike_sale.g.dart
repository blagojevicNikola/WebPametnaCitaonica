// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karakteristike_sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KarakteristikeSale _$KarakteristikeSaleFromJson(Map<String, dynamic> json) =>
    KarakteristikeSale(
      karakteristikaId: json['karakteristikaId'] as int?,
      detalji: json['detalji'] as String?,
      naziv: json['karakteristikaNaziv'] as String?,
    );

Map<String, dynamic> _$KarakteristikeSaleToJson(KarakteristikeSale instance) =>
    <String, dynamic>{
      'karakteristikaId': instance.karakteristikaId,
      'karakteristikaNaziv': instance.naziv,
      'detalji': instance.detalji,
    };

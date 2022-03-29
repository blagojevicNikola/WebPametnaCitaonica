// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clanarina.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clanarina _$ClanarinaFromJson(Map<String, dynamic> json) => Clanarina(
      cijena: (json['cijena'] as num?)?.toDouble(),
      vremenskiPeriodNaziv: json['vremenskiPeriodNaziv'] as String?,
    );

Map<String, dynamic> _$ClanarinaToJson(Clanarina instance) => <String, dynamic>{
      'vremenskiPeriodNaziv': instance.vremenskiPeriodNaziv,
      'cijena': instance.cijena,
    };

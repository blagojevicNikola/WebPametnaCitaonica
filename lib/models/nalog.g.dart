// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nalog _$NalogFromJson(Map<String, dynamic> json) => Nalog(
      ime: json['ime'] as String,
      prezime: json['prezime'] as String,
      korisnickoIme: json['korisnickoIme'] as String,
      mail: json['mail'] as String,
      id: json['id'] as int?,
      lozinka: json['lozinka'] as String?,
    );

Map<String, dynamic> _$NalogToJson(Nalog instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnickoIme': instance.korisnickoIme,
      'lozinka': instance.lozinka,
      'mail': instance.mail,
    };

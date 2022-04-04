// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebLogin _$WebLoginFromJson(Map<String, dynamic> json) => WebLogin(
      id: json['id'] as int?,
      ime: json['ime'] as String,
      prezime: json['prezime'] as String,
      korisnickoIme: json['korisnickoIme'] as String,
      mail: json['mail'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      uloga: json['uloga'] as String,
    );

Map<String, dynamic> _$WebLoginToJson(WebLogin instance) => <String, dynamic>{
      'id': instance.id,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnickoIme': instance.korisnickoIme,
      'mail': instance.mail,
      'refreshToken': instance.refreshToken,
      'accessToken': instance.accessToken,
      'uloga': instance.uloga,
    };

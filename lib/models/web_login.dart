import 'package:json_annotation/json_annotation.dart';

part 'web_login.g.dart';

@JsonSerializable()
class WebLogin {
  int? id;
  String ime;
  String prezime;
  String korisnickoIme;
  String mail;
  String refreshToken;
  String accessToken;
  String? uloga;

  WebLogin(
      {this.id,
      required this.ime,
      required this.prezime,
      required this.korisnickoIme,
      required this.mail,
      required this.accessToken,
      required this.refreshToken,
      required this.uloga});

  factory WebLogin.fromJson(Map<String, dynamic> json) =>
      _$WebLoginFromJson(json);
  Map<String, dynamic> toJson() => _$WebLoginToJson(this);
}

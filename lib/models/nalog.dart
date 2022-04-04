import 'package:json_annotation/json_annotation.dart';

part 'nalog.g.dart';

@JsonSerializable()
class Nalog {
  int? id;
  String ime;
  String prezime;
  String korisnickoIme;
  String? lozinka;
  String mail;

  Nalog(
      {required this.ime,
      required this.prezime,
      required this.korisnickoIme,
      required this.mail,
      this.id,
      this.lozinka});

  factory Nalog.fromJson(Map<String, dynamic> json) => _$NalogFromJson(json);
  Map<String, dynamic> toJson() => _$NalogToJson(this);
}

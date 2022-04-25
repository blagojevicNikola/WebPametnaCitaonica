import 'package:json_annotation/json_annotation.dart';

part 'zaboravljena_lozinka_email.g.dart';

@JsonSerializable()
class ZaboravljenaLozinkaEmail {
  String email;

  ZaboravljenaLozinkaEmail({required this.email});

  factory ZaboravljenaLozinkaEmail.fromJson(Map<String, dynamic> json) =>
      _$ZaboravljenaLozinkaEmailFromJson(json);
  Map<String, dynamic> toJson() => _$ZaboravljenaLozinkaEmailToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'promjena_lozinke.g.dart';

@JsonSerializable()
class PromjenaLozinke {
  String staraLozinka;
  String novaLozinka;

  PromjenaLozinke({
    required this.staraLozinka,
    required this.novaLozinka,
  });

  factory PromjenaLozinke.fromJson(Map<String, dynamic> json) =>
      _$PromjenaLozinkeFromJson(json);
  Map<String, dynamic> toJson() => _$PromjenaLozinkeToJson(this);
}

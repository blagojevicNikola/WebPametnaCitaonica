import 'package:json_annotation/json_annotation.dart';

import 'mjesto.dart';

part 'individualna_sala.g.dart';

@JsonSerializable()
class IndividualnaSala {
  int? id;
  String naziv;
  @JsonKey(name: 'broj_mjesta')
  int? brojMjesta;
  @JsonKey(name: 'lista_mjesta')
  List<Mjesto>? listaMjesta;
  @JsonKey(name: 'slika_url')
  String slikaURL;

  IndividualnaSala(
      {this.id, required this.naziv, this.listaMjesta, required this.slikaURL});

  factory IndividualnaSala.fromJson(Map<String, dynamic> json) =>
      _$IndividualnaSalaFromJson(json);
  Map<String, dynamic> toJson() => _$IndividualnaSalaToJson(this);
}

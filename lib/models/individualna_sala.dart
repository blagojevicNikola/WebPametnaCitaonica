import 'package:json_annotation/json_annotation.dart';
import 'package:web_aplikacija/models/karakteristike_sale.dart';

import 'clanarina.dart';

part 'individualna_sala.g.dart';

@JsonSerializable()
class IndividualnaSala {
  int? id;
  @JsonKey(name: 'oznakaSale')
  String naziv;
  @JsonKey(name: 'kapacitet')
  int? brojMjesta;
  String? opis;
  List<Clanarina?> clanarine;
  List<KarakteristikeSale?> karakteristike;

  IndividualnaSala(
      {this.id,
      required this.naziv,
      this.brojMjesta,
      this.opis,
      required this.clanarine,
      required this.karakteristike});

  factory IndividualnaSala.fromJson(Map<String, dynamic> json) =>
      _$IndividualnaSalaFromJson(json);
  Map<String, dynamic> toJson() => _$IndividualnaSalaToJson(this);
}

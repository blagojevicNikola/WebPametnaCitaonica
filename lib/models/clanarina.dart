import 'package:json_annotation/json_annotation.dart';

part 'clanarina.g.dart';

@JsonSerializable()
class Clanarina {
  String? vremenskiPeriodNaziv;
  double? cijena;

  Clanarina({
    this.cijena,
    this.vremenskiPeriodNaziv,
  });

  factory Clanarina.fromJson(Map<String, dynamic> json) =>
      _$ClanarinaFromJson(json);
  Map<String, dynamic> toJson() => _$ClanarinaToJson(this);
}

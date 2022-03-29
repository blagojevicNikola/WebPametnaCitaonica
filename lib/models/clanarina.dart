import 'package:json_annotation/json_annotation.dart';

part 'clanarina.g.dart';

@JsonSerializable()
class Clanarina {
  int? vremenskiPeriodNaziv;
  double? cijena;

  Clanarina({this.vremenskiPeriodNaziv, this.cijena});

  factory Clanarina.fromJson(Map<String, dynamic> json) =>
      _$ClanarinaFromJson(json);
  Map<String, dynamic> toJson() => _$ClanarinaToJson(this);
}

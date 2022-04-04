import 'package:json_annotation/json_annotation.dart';

part 'obavjestenje.g.dart';

@JsonSerializable()
class Obavjestenje {
  @JsonKey(name: 'id')
  int? idObavjestenja;
  int? idSupervizora;
  @JsonKey(name: 'vrijeme')
  DateTime? vrijemeSlanja;
  @JsonKey(name: 'naslov')
  String naslov;
  @JsonKey(name: 'sadrzaj')
  String tekstNotifikacije;

  Obavjestenje({required this.naslov, required this.tekstNotifikacije});

  factory Obavjestenje.fromJson(Map<String, dynamic> json) =>
      _$ObavjestenjeFromJson(json);
  Map<String, dynamic> toJson() => _$ObavjestenjeToJson(this);
}

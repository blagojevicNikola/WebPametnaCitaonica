import 'package:json_annotation/json_annotation.dart';

part 'karakteristike_sale.g.dart';

@JsonSerializable()
class KarakteristikeSale {
  int? karakteristikaId;
  @JsonKey(name: 'karakteristikaNaziv')
  String? naziv;
  String? detalji;

  KarakteristikeSale({this.karakteristikaId, this.detalji, this.naziv});

  factory KarakteristikeSale.fromJson(Map<String, dynamic> json) =>
      _$KarakteristikeSaleFromJson(json);
  Map<String, dynamic> toJson() => _$KarakteristikeSaleToJson(this);
}

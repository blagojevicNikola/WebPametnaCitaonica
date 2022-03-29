import 'package:json_annotation/json_annotation.dart';

part 'karakteristike_sale.g.dart';

@JsonSerializable()
class KarakteristikeSale {
  int? karakteristikaId;
  String? detalji;

  KarakteristikeSale({this.karakteristikaId, this.detalji});

  factory KarakteristikeSale.fromJson(Map<String, dynamic> json) =>
      _$KarakteristikeSaleFromJson(json);
  Map<String, dynamic> toJson() => _$KarakteristikeSaleToJson(this);
}

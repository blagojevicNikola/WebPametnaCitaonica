import 'package:json_annotation/json_annotation.dart';

part 'karakteristike.g.dart';

@JsonSerializable()
class Karakteristike {
  int? id;
  String? naziv;

  Karakteristike({this.id, this.naziv});

  factory Karakteristike.fromJson(Map<String, dynamic> json) =>
      _$KarakteristikeFromJson(json);
  Map<String, dynamic> toJson() => _$KarakteristikeToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part "pozicijaXY.g.dart";

@JsonSerializable()
class PozicijaXY {
  double x;
  double y;

  PozicijaXY({required this.x, required this.y});

  factory PozicijaXY.fromJson(Map<String, dynamic> json) =>
      _$PozicijaXYFromJson(json);
  Map<String, dynamic> toJson() => _$PozicijaXYToJson(this);
}

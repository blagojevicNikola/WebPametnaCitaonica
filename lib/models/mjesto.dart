import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:web_aplikacija/converter/custom_offset_converter.dart';
part 'mjesto.g.dart';

@JsonSerializable()
@CustomOffsetConverter()
class Mjesto {
  int? id;
  @JsonKey(name: 'broj_mjesta')
  int brojMjesta;
  @JsonKey(name: 'qr_code')
  String qrCode;
  double velicina;
  double ugao;
  Offset pozicija;

  Mjesto(
      {required this.pozicija,
      required this.velicina,
      required this.ugao,
      required this.qrCode,
      required this.brojMjesta,
      this.id});

  factory Mjesto.fromJson(Map<String, dynamic> json) => _$MjestoFromJson(json);
  Map<String, dynamic> toJson() => _$MjestoToJson(this);
}

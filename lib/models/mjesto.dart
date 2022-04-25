import 'package:json_annotation/json_annotation.dart';
import 'package:web_aplikacija/converter/custom_offset_converter.dart';
import 'package:web_aplikacija/models/pozicijaXY.dart';
part 'mjesto.g.dart';

@JsonSerializable()
@CustomOffsetConverter()
class Mjesto {
  int? id;
  @JsonKey(name: 'brojMjesta')
  int brojMjesta;
  @JsonKey(name: 'kod')
  String qrCode;
  double velicina;
  int ugao;
  bool uticnica;
  bool dostupno;
  PozicijaXY pozicija;

  Mjesto(
      {required this.pozicija,
      required this.velicina,
      required this.ugao,
      required this.qrCode,
      required this.brojMjesta,
      required this.dostupno,
      required this.uticnica,
      this.id});

  factory Mjesto.fromJson(Map<String, dynamic> json) => _$MjestoFromJson(json);
  Map<String, dynamic> toJson() => _$MjestoToJson(this);
}

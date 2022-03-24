import 'package:json_annotation/json_annotation.dart';

enum Dan {
  @JsonValue("ponedeljak")
  Ponedeljak,
  @JsonValue("utorak")
  Utorak,
  @JsonValue("srijeda")
  Srijeda,
  @JsonValue("cetvrtak")
  Cetrvrtak,
  @JsonValue("petak")
  Petak,
  @JsonValue("subota")
  Subota,
  @JsonValue("nedelja")
  Nedelja,
}

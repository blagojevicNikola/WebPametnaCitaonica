import 'package:json_annotation/json_annotation.dart';

part 'argumenti_prikaza_individualne_rezervacije_mjesta.g.dart';

@JsonSerializable()
class ArgumentiPrikazaIndividualneRezervacijeMjesta {
  DateTime vrijemeVazenjaOd;
  DateTime vrijemeVazenjaDo;

  ArgumentiPrikazaIndividualneRezervacijeMjesta({
    required this.vrijemeVazenjaOd,
    required this.vrijemeVazenjaDo,
  });

  factory ArgumentiPrikazaIndividualneRezervacijeMjesta.fromJson(
          Map<String, dynamic> json) =>
      _$ArgumentiPrikazaIndividualneRezervacijeMjestaFromJson(json);
  Map<String, dynamic> toJson() =>
      _$ArgumentiPrikazaIndividualneRezervacijeMjestaToJson(this);
}

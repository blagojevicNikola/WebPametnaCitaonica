import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:web_aplikacija/converter/custom_timeofday_converter.dart';

part 'radno_vrijeme.g.dart';

@JsonSerializable()
@CustomTimeOfDayConverter()
class RadnoVrijemeUDanu {
  int? id;
  TimeOfDay? pocetak;
  TimeOfDay? kraj;

  RadnoVrijemeUDanu({this.id, this.pocetak, this.kraj});

  factory RadnoVrijemeUDanu.fromJson(Map<String, dynamic> json) =>
      _$RadnoVrijemeUDanuFromJson(json);
  Map<String, dynamic> toJson() => _$RadnoVrijemeUDanuToJson(this);
}

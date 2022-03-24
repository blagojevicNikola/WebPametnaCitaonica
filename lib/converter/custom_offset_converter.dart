import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

class CustomOffsetConverter implements JsonConverter<Offset, String> {
  const CustomOffsetConverter();
  @override
  Offset fromJson(String json) {
    return Offset(
        double.parse(json.split(".")[0]), double.parse(json.split(".")[1]));
  }

  @override
  String toJson(Offset object) {
    String pozicija = '${object.dx.toString()}.${object.dy.toString()}';
    return pozicija;
  }
}

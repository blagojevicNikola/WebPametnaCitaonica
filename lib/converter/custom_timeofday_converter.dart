import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class CustomTimeOfDayConverter implements JsonConverter<TimeOfDay?, String?> {
  const CustomTimeOfDayConverter();
  @override
  TimeOfDay? fromJson(String? json) {
    if (json == null) {
      return null;
    } else {
      return TimeOfDay(
        hour: int.parse(json.split(":")[0]),
        minute: int.parse(json.split(":")[1]),
      );
    }
  }

  @override
  String? toJson(TimeOfDay? object) {
    if (object == null) {
      return null;
    } else {
      String vrijednost =
          '${object.hour.toString().padLeft(2, '0')}:${object.minute.toString().padLeft(2, '0')}:00';
      return vrijednost;
    }
  }
}

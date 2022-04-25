import 'package:json_annotation/json_annotation.dart';

part 'reset_lozinke.g.dart';

@JsonSerializable()
class ResetLozinke {
  String token;
  String lozinka;

  ResetLozinke({required this.token, required this.lozinka});

  factory ResetLozinke.fromJson(Map<String, dynamic> json) =>
      _$ResetLozinkeFromJson(json);
  Map<String, dynamic> toJson() => _$ResetLozinkeToJson(this);
}

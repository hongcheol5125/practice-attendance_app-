import 'package:json_annotation/json_annotation.dart';

part 'number.g.dart';

@JsonSerializable()
class Number{
  final String number;
  final String? attendance;

  Number({required this.number, this.attendance});

  factory Number.fromJson(Map<String, dynamic> json) => _$NumberFromJson(json);
  Map<String, dynamic>toJson() => _$NumberToJson(this);
}
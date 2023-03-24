import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';


@JsonSerializable()
class User{
  final String id;
  final String password;
  final String? type;

  User({required this.id, required this.password, this.type});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic>toJson() => _$UserToJson(this);
}

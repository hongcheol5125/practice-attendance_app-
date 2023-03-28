import 'package:json_annotation/json_annotation.dart';

part 'myevents.g.dart';

@JsonSerializable()
class MyEvents {
    final String event;
    final DateTime date;
    final String? description;

    MyEvents({required this.event, required this.date, this.description});

    factory MyEvents.fromJson(Map<String, dynamic> json) => _$MyEventsFromJson(json);
    Map<String, dynamic>toJson() => _$MyEventsToJson(this);
}
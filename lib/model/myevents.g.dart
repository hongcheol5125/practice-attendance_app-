// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myevents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyEvents _$MyEventsFromJson(Map<String, dynamic> json) => MyEvents(
      event: json['event'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$MyEventsToJson(MyEvents instance) => <String, dynamic>{
      'event': instance.event,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleImpl _$$ScheduleImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleImpl(
      id: json['id'] as String,
      time: DateTime.parse(json['time'] as String),
      value: (json['value'] as num).toInt(),
      status: json['status'] as bool,
    );

Map<String, dynamic> _$$ScheduleImplToJson(_$ScheduleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time.toIso8601String(),
      'value': instance.value,
      'status': instance.status,
    };

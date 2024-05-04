// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryImpl _$$HistoryImplFromJson(Map<String, dynamic> json) =>
    _$HistoryImpl(
      temp: (json['temp'] as num).toInt(),
      humi: (json['humi'] as num).toInt(),
      brightness: (json['brightness'] as num).toInt(),
      dateTime: DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$$HistoryImplToJson(_$HistoryImpl instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'humi': instance.humi,
      'brightness': instance.brightness,
      'dateTime': instance.dateTime.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'led.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedImpl _$$LedImplFromJson(Map<String, dynamic> json) => _$LedImpl(
      group: json['group'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as bool,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      autoMode: json['autoMode'] as bool,
      temp: (json['temp'] as num?)?.toInt(),
      humi: (json['humi'] as num?)?.toInt(),
      brightness: (json['brightness'] as num?)?.toInt(),
      incli: json['incli'] as String?,
      x: json['x'] as String?,
      y: json['y'] as String?,
      z: json['z'] as String?,
      rsrp: (json['rsrp'] as num?)?.toInt(),
      cellID: (json['cellID'] as num?)?.toInt(),
      histories: (json['histories'] as List<dynamic>?)
              ?.map((e) => History.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      schedules: (json['schedules'] as List<dynamic>?)
              ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$LedImplToJson(_$LedImpl instance) => <String, dynamic>{
      'group': instance.group,
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'lat': instance.lat,
      'lon': instance.lon,
      'autoMode': instance.autoMode,
      'temp': instance.temp,
      'humi': instance.humi,
      'brightness': instance.brightness,
      'incli': instance.incli,
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
      'rsrp': instance.rsrp,
      'cellID': instance.cellID,
      'histories': instance.histories,
      'schedules': instance.schedules,
    };

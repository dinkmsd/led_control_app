// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      id: json['id'] as String,
      numLeds: (json['numLeds'] as num).toInt(),
      ledActive: (json['ledActive'] as num).toInt(),
      ledError: (json['ledError'] as num).toInt(),
      groupName: json['groupName'] as String,
      status: json['status'] as bool,
      leds: (json['leds'] as List<dynamic>?)
              ?.map((e) => Led.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'numLeds': instance.numLeds,
      'ledActive': instance.ledActive,
      'ledError': instance.ledError,
      'groupName': instance.groupName,
      'status': instance.status,
      'leds': instance.leds,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      groupName: json['groupName'] as String,
      status: json['status'] as bool,
      leds: (json['leds'] as List<dynamic>?)
              ?.map((e) => Led.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'groupName': instance.groupName,
      'status': instance.status,
      'leds': instance.leds,
    };

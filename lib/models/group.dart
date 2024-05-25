import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:led_control_app/models/led.dart';
import 'package:led_control_app/models/schedule.dart';
part 'group.freezed.dart';
part 'group.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Group with _$Group {
  factory Group({
    required String id,
    required int numLeds,
    required int ledActive,
    required int ledError,
    required String groupName,
    required bool status,
    @Default([]) List<Led> leds,
    @Default([]) List<Schedule> schedules,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}

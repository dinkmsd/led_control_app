import 'package:freezed_annotation/freezed_annotation.dart';
part 'schedule.freezed.dart';
part 'schedule.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Schedule with _$Schedule {
  factory Schedule({
    required String id,
    required String time,
    required int value,
    required bool status,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}

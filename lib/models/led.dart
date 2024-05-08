import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:led_control_app/models/history.dart';
import 'package:led_control_app/models/schedule.dart';
part 'led.freezed.dart';
part 'led.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Led with _$Led {
  factory Led({
    required String id,
    required String name,
    required bool status,
    required double lat,
    required double lon,
    int? temp,
    int? humi,
    int? brightness,
    String? incli,
    String? x,
    String? y,
    String? z,
    int? rsrp,
    int? cellID,
    @Default([]) List<History> histories,
    @Default([]) List<Schedule> schedules,
  }) = _Led;

  factory Led.fromJson(Map<String, dynamic> json) => _$LedFromJson(json);
}

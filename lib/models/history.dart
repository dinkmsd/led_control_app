import 'package:freezed_annotation/freezed_annotation.dart';
part 'history.freezed.dart';
part 'history.g.dart';

@freezed
class History with _$History {
  factory History({
    required int temp,
    required int humi,
    required int brightness,
    required DateTime dateTime,
  }) = _History;

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);
}

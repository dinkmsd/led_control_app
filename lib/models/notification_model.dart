import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:led_control_app/models/led.dart';
part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

// class NotificationModule {
//   final String id;
//   final String title;
//   final String ledId;
//   final String event;
//   NotificationModule({
//     required this.id,
//     required this.title,
//     required this.ledId,
//     required this.event,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'ledId': ledId,
//       'title': title,
//       'event': event,
//     };
//   }

//   factory NotificationModule.fromMap(Map<String, dynamic> map) {
//     return NotificationModule(
//       id: map['_id'] ?? '',
//       title: map['title'] ?? '',
//       ledId: map['ledId'] ?? '',
//       event: map['event'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory NotificationModule.fromJson(Map<String, dynamic> source) =>
//       NotificationModule.fromMap(source);
// }

@freezed
class NotificationModel with _$NotificationModel {
  factory NotificationModel({
    required String id,
    required String title,
    required String event,
    required Led led,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

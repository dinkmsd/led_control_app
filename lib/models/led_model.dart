// import 'package:intl/intl.dart';

// class LedInfo {
//   String id;
//   String name;
//   bool status;
//   double lat;
//   double lon;
//   int? temp;
//   int? humi;
//   int? brightness;
//   String? incli;
//   String? x;
//   String? y;
//   String? z;
//   int? rsrp;
//   int? cellID;
//   List<HistoryItem> history = [];
//   List<Schedule> schedule = [];
//   LedInfo(
//       {required this.id,
//       required this.name,
//       this.status = false,
//       required this.lat,
//       required this.lon,
//       this.temp,
//       this.humi,
//       this.brightness,
//       this.incli,
//       this.x,
//       this.y,
//       this.z,
//       this.rsrp,
//       this.cellID,
//       required this.history,
//       required this.schedule});

//   LedInfo copyWith(
//       String? id,
//       String? name,
//       bool? status,
//       double? lat,
//       double? lon,
//       int? temp,
//       int? humi,
//       int? brightness,
//       String? incli,
//       String? x,
//       String? y,
//       String? z,
//       int? rsrp,
//       int? cellID,
//       List<HistoryItem>? history,
//       List<Schedule>? schedule) {
//     return LedInfo(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         status: status ?? this.status,
//         lat: lat ?? this.lat,
//         lon: lon ?? this.lon,
//         temp: temp ?? this.temp,
//         humi: humi ?? this.humi,
//         brightness: brightness ?? this.brightness,
//         incli: incli ?? this.incli,
//         x: x ?? this.x,
//         y: y ?? this.y,
//         z: z ?? this.z,
//         rsrp: rsrp ?? this.rsrp,
//         cellID: cellID ?? this.cellID,
//         history: history ?? this.history,
//         schedule: schedule ?? this.schedule);
//   }

//   factory LedInfo.fromJson(Map<String, Object?> jsonData) {
//     List<HistoryItem> historyTmp = [];
//     if (jsonData['history'] != null) {
//       var listHistory = jsonData['history'] as List;
//       historyTmp =
//           listHistory.map((item) => HistoryItem.fromJson(item)).toList();
//     }

//     List<Schedule> scheduleTmp = [];
//     if (jsonData['schedule'] != null) {
//       scheduleTmp = (jsonData['schedule'] as List)
//           .map((item) => Schedule.fromJson(item))
//           .toList();
//     }

//     return LedInfo(
//         id: jsonData['_id'] as String,
//         name: jsonData['name'] as String,
//         lat: jsonData['lat'] is double
//             ? jsonData['lat'] as double
//             : (jsonData['lat'] as int).toDouble(),
//         lon: jsonData['lon'] is double
//             ? jsonData['lon'] as double
//             : (jsonData['lon'] as int).toDouble(),
//         status: jsonData['status'] as bool,
//         temp: jsonData['temp'] != null ? jsonData['temp'] as int : null,
//         humi: jsonData['humi'] != null ? jsonData['humi'] as int : null,
//         brightness: jsonData['brightness'] != null
//             ? jsonData['brightness'] as int
//             : null,
//         incli: jsonData['incli'] != null ? jsonData['incli'] as String : null,
//         x: jsonData['x'] != null ? jsonData['x'] as String : null,
//         y: jsonData['y'] != null ? jsonData['y'] as String : null,
//         z: jsonData['z'] != null ? jsonData['z'] as String : null,
//         rsrp: jsonData['rsrp'] != null ? jsonData['rsrp'] as int : null,
//         cellID: jsonData['cellID'] != null ? jsonData['cellID'] as int : null,
//         history: historyTmp,
//         schedule: scheduleTmp);
//   }
// }

// class HistoryItem {
//   int temp;
//   int humi;
//   int brightness;
//   DateTime dateTime;
//   HistoryItem(
//       {required this.temp,
//       required this.humi,
//       required this.brightness,
//       required this.dateTime});

//   factory HistoryItem.fromJson(Map<String, Object?> json) {
//     return HistoryItem(
//         temp: json['temperature'] as int,
//         humi: json['humidity'] as int,
//         brightness: json['brightness'] as int,
//         dateTime: DateTime.parse(json['dateTime'] as String));
//   }

//   Map<String, Object?> toJson() {
//     return {
//       "temperature": temp,
//       "humidity": humi,
//       "brightness": brightness,
//       "dateTime": dateTime.toString()
//     };
//   }
// }

// class Schedule {
//   String id;
//   DateTime time;
//   int value;
//   bool status;
//   Schedule(
//       {required this.id,
//       required this.time,
//       required this.value,
//       this.status = true});

//   factory Schedule.fromJson(Map<String, Object?> json) {
//     String timeString = json['time'] as String;
//     DateFormat formatter = DateFormat('hh:mm a');

//     DateTime parsedTime = formatter.parse(timeString);
//     return Schedule(
//         id: json['_id'] as String,
//         time: parsedTime,
//         value: json['value'] as int,
//         status: json['status'] as bool);
//   }

//   Map<String, Object?> toJson() {
//     return {"time": time.toString(), "value": value, "status": status};
//   }
// }

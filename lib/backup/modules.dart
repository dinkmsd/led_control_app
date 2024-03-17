import 'package:intl/intl.dart';

class LightInfo {
  String id;
  String name;
  bool status;
  double lat;
  double lon;
  int? temp;
  int? humi;
  int? brightness;
  String? incli;
  String? x;
  String? y;
  String? z;
  int? rsrp;
  int? cellID;
  List<HistoryItem> history = [];
  List<Schedule> schedule = [];
  LightInfo(
      {required this.id,
      required this.name,
      this.status = false,
      required this.lat,
      required this.lon,
      this.temp,
      this.humi,
      this.brightness,
      this.incli,
      this.x,
      this.y,
      this.z,
      this.rsrp,
      this.cellID,
      required this.history,
      required this.schedule});
  factory LightInfo.fromJson(Map<String, Object?> jsonData) {
    List<HistoryItem> historyTmp = [];
    if (jsonData['history'] != null) {
      var listHistory = jsonData['history'] as List;
      historyTmp =
          listHistory.map((item) => HistoryItem.fromJson(item)).toList();
    }

    List<Schedule> scheduleTmp = [];
    if (jsonData['schedule'] != null) {
      scheduleTmp = (jsonData['schedule'] as List)
          .map((item) => Schedule.fromJson(item))
          .toList();
    }

    return LightInfo(
        id: jsonData['_id'] as String,
        name: jsonData['name'] as String,
        lat: jsonData['lat'] as double,
        lon: jsonData['lon'] as double,
        status: jsonData['status'] as bool,
        temp: jsonData['temp'] != null ? jsonData['temp'] as int : null,
        humi: jsonData['humi'] != null ? jsonData['humi'] as int : null,
        brightness: jsonData['brightness'] != null
            ? jsonData['brightness'] as int
            : null,
        incli: jsonData['incli'] != null ? jsonData['incli'] as String : null,
        x: jsonData['x'] != null ? jsonData['x'] as String : null,
        y: jsonData['y'] != null ? jsonData['y'] as String : null,
        z: jsonData['z'] != null ? jsonData['z'] as String : null,
        rsrp: jsonData['rsrp'] != null ? jsonData['rsrp'] as int : null,
        cellID: jsonData['cellID'] != null ? jsonData['cellID'] as int : null,
        history: historyTmp,
        schedule: scheduleTmp);
  }

  // String? incli;
  // String? x;
  // String? y;
  // String? z;
  // int? rsrp;
  // int? cellID;
}

class HistoryItem {
  int temp;
  int humi;
  int brightness;
  DateTime dateTime;
  HistoryItem(
      {required this.temp,
      required this.humi,
      required this.brightness,
      required this.dateTime});

  factory HistoryItem.fromJson(Map<String, Object?> json) {
    return HistoryItem(
        temp: json['temperature'] as int,
        humi: json['humidity'] as int,
        brightness: json['brightness'] as int,
        dateTime: DateTime.parse(json['dateTime'] as String));
  }

  Map<String, Object?> toJson() {
    return {
      "temperature": temp,
      "humidity": humi,
      "brightness": brightness,
      "dateTime": dateTime.toString()
    };
  }
}

class Schedule {
  String id;
  DateTime time;
  int value;
  bool status;
  Schedule(
      {required this.id,
      required this.time,
      required this.value,
      this.status = true});

  factory Schedule.fromJson(Map<String, Object?> json) {
    DateFormat dateFormat = DateFormat('hh:mm a');
    DateTime dateTime = dateFormat.parse(json['time'] as String);
    return Schedule(
        id: json['_id'] as String,
        time: dateTime,
        value: json['value'] as int,
        status: json['status'] as bool);
  }

  Map<String, Object?> toJson() {
    return {
      "time": time.toString(),
      "value": value,
      "status": status
    };
  }
}

class TempData {
  final String time;
  final double value;
  TempData({required this.time, required this.value});
}

class HumiData {
  final String time;
  final double value;
  HumiData({required this.time, required this.value});
}

class BrightData {
  final String time;
  final int value;
  BrightData({required this.time, required this.value});
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:led_control_app/models/led_model.dart';
import 'package:led_control_app/providers/schedule_provider.dart';
import 'package:provider/provider.dart';

class ScheduleService {
  void getSchedule(BuildContext context) async {
    var scheduleProvider =
        Provider.of<ScheduleProvider>(context, listen: false);
    final token = scheduleProvider.token;
    var id = scheduleProvider.id;
    http.Response res = await http.get(
      Uri.parse('http://10.0.2.2:8080/schedule'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
        'id': id,
      },
    );
    if (res.statusCode == 200) {
      List<dynamic> body = json.decode(res.body);
      List<Schedule> schedules = body.map((e) => Schedule.fromJson(e)).toList();
      scheduleProvider.loadSuccessed(schedules);
    }
  }

  void setSchedule(BuildContext context, String value) async {
    var scheduleProvider =
        Provider.of<ScheduleProvider>(context, listen: false);
    final token = scheduleProvider.token;

    var id = scheduleProvider.id;

    var msg = jsonEncode({
      'ledID': id,
      'time': scheduleProvider.timeString,
      'value': value,
      'status': true.toString()
    });
    http.Response res =
        await http.post(Uri.parse('http://10.0.2.2:8080/schedule'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: msg);
    if (res.statusCode == 200) {
      List<dynamic> body = json.decode(res.body);
      List<Schedule> schedules = body.map((e) => Schedule.fromJson(e)).toList();
      scheduleProvider.loadSuccessed(schedules);
    }
  }

  void deleteSchedule(BuildContext context, String scheID) async {
    var scheduleProvider =
        Provider.of<ScheduleProvider>(context, listen: false);
    final token = scheduleProvider.token;

    var ledID = scheduleProvider.id;

    var msg = jsonEncode({
      'ledID': ledID,
      'scheID': scheID,
    });

    http.Response res =
        await http.delete(Uri.parse('http://10.0.2.2:8080/schedule'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: msg);

    if (res.statusCode == 200) {
      List<dynamic> body = json.decode(res.body);
      List<Schedule> schedules = body.map((e) => Schedule.fromJson(e)).toList();
      scheduleProvider.loadSuccessed(schedules);
    }
  }

  void updateSchedule(BuildContext context, String scheID, bool status) async {
    var scheduleProvider =
        Provider.of<ScheduleProvider>(context, listen: false);
    final token = scheduleProvider.token;

    var ledID = scheduleProvider.id;
    final msg = jsonEncode({
      'ledID': ledID,
      'scheID': scheID,
      'status': status.toString(),
    });
    http.Response res =
        await http.put(Uri.parse('http://10.0.2.2:8080/schedule'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: msg);

    if (res.statusCode == 200) {
      List<dynamic> body = json.decode(res.body);
      List<Schedule> schedules = body.map((e) => Schedule.fromJson(e)).toList();
      scheduleProvider.loadSuccessed(schedules);
    }
  }

  void setTimer(BuildContext context, String timeString) {
    var scheduleProvider =
        Provider.of<ScheduleProvider>(context, listen: false);
    scheduleProvider.setTimer(timeString);
  }

  String getTimer(BuildContext context) {
    var scheduleProvider =
        Provider.of<ScheduleProvider>(context, listen: false);
    return scheduleProvider.timeString;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:led_control_app/models/schedule.dart';
import 'package:led_control_app/providers/schedule_provider.dart';
import 'package:provider/provider.dart';
import 'package:led_control_app/utils/constant.dart';

class ScheduleService {
  void getSchedule(BuildContext context) async {
    var scheduleProvider =
        Provider.of<ScheduleProvider>(context, listen: false);
    final token = scheduleProvider.token;
    var id = scheduleProvider.id;
    http.Response res = await http.get(
      Uri.parse('${HOST}/led/schedule/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      List<dynamic> body = json.decode(res.body)['data'];
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
      'ledId': id,
      'time': scheduleProvider.timeString,
      'value': int.parse(value),
    });

    print(msg);

    http.Response res = await http.post(Uri.parse('${HOST}/led/schedule'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: msg);
    if (res.statusCode == 200) {
      print(res.body);
      List<dynamic> body = json.decode(res.body)['data'];
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
      'ledId': ledID,
      'scheduleId': scheID,
    });

    http.Response res = await http.delete(Uri.parse('${HOST}/led/schedule'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: msg);

    if (res.statusCode == 200) {
      List<dynamic> body = json.decode(res.body)['data'];
      List<Schedule> schedules = body.map((e) => Schedule.fromJson(e)).toList();
      scheduleProvider.loadSuccessed(schedules);
    }
  }

  void updateSchedule(BuildContext context, int scheIdx, bool status) async {
    var scheduleProvider =
        Provider.of<ScheduleProvider>(context, listen: false);
    final token = scheduleProvider.token;
    var scheId = scheduleProvider.schedules[scheIdx].id;
    var ledID = scheduleProvider.id;
    final msg = jsonEncode({
      'ledId': ledID,
      'scheduleId': scheId,
      'status': status,
    });
    http.Response res = await http.patch(Uri.parse('${HOST}/led/schedule'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: msg);
    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      bool status = body['status'];
      scheduleProvider.updateStatus(scheIdx, status);
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

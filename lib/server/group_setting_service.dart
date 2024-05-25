import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:led_control_app/models/schedule.dart';
import 'package:led_control_app/providers/group_setting_provider.dart';
import 'package:provider/provider.dart';
import 'package:led_control_app/utils/constant.dart';

class GroupSettingService {
  void getSchedule(BuildContext context) async {
    var scheduleProvider =
        Provider.of<GroupSettingProvider>(context, listen: false);
    final token = scheduleProvider.token;
    var id = scheduleProvider.id;
    http.Response res = await http.get(
      Uri.parse('${HOST}/group/schedule/$id'),
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
        Provider.of<GroupSettingProvider>(context, listen: false);
    final token = scheduleProvider.token;

    var id = scheduleProvider.id;

    var msg = jsonEncode({
      'groupId': id,
      'time': scheduleProvider.timeString,
      'value': int.parse(value),
    });

    http.Response res =
        await http.post(Uri.parse('${HOST}/group/create-schedule'),
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

  void deleteSchedule(BuildContext context, String scheId) async {
    var scheduleProvider =
        Provider.of<GroupSettingProvider>(context, listen: false);
    final token = scheduleProvider.token;

    var groupId = scheduleProvider.id;

    var msg = jsonEncode({
      'groupId': groupId,
      'scheduleId': scheId,
    });

    http.Response res = await http.delete(Uri.parse('${HOST}/group/schedule'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: msg);

    if (res.statusCode == 200) {
      print(json.decode(res.body)['data']);
      List<dynamic> body = json.decode(res.body)['data'];
      List<Schedule> schedules = body.map((e) => Schedule.fromJson(e)).toList();
      scheduleProvider.loadSuccessed(schedules);
    }
  }

  void updateSchedule(BuildContext context, String scheID, bool status) async {
    var scheduleProvider =
        Provider.of<GroupSettingProvider>(context, listen: false);
    final token = scheduleProvider.token;

    var ledID = scheduleProvider.id;
    final msg = jsonEncode({
      'groupId': ledID,
      'scheId': scheID,
      'status': status,
    });
    http.Response res = await http.patch(Uri.parse('${HOST}/group/schedule'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: msg);
    print(res.body.toString());
    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      var schedule = scheduleProvider.schedules
          .firstWhere((element) => element.id == scheID);
      schedule = schedule.copyWith(status: body['status']);
      scheduleProvider.loadSuccessed(scheduleProvider.schedules);
    }
  }

  void setTimer(BuildContext context, String timeString) {
    var scheduleProvider =
        Provider.of<GroupSettingProvider>(context, listen: false);
    scheduleProvider.setTimer(timeString);
  }

  String getTimer(BuildContext context) {
    var scheduleProvider =
        Provider.of<GroupSettingProvider>(context, listen: false);
    return scheduleProvider.timeString;
  }
}

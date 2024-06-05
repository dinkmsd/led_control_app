import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:led_control_app/models/notification_model.dart';
import 'package:led_control_app/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:led_control_app/utils/constant.dart';

class NotificationService {
  void getNotification(BuildContext context) async {
    var notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    final token = notificationProvider.token;
    http.Response res = await http.get(
      Uri.parse('${HOST}/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      List<dynamic> body = json.decode(res.body);
      List<NotificationModel> schedules =
          body.map((e) => NotificationModel.fromJson(e)).toList();
      notificationProvider.loadSuccessed(schedules);
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:led_control_app/models/group.dart';
import 'package:led_control_app/models/led.dart';
import 'package:led_control_app/providers/group_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:led_control_app/utils/constant.dart';

class GroupDetailService {
  void getDetailGroup(BuildContext context) async {
    var groupDetailProvider =
        Provider.of<GroupDetailProvider>(context, listen: false);
    http.Response res = await http.post(Uri.parse('${HOST}/group/detail-group'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${groupDetailProvider.token}'
        },
        body: jsonEncode({
          'groupId': groupDetailProvider.group.id,
        }));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      Group groupDetal = Group.fromJson(data);
      groupDetailProvider.loadSuccessed(groupDetal);
    }
  }

  void updateData({required BuildContext context, required dynamic data}) {
    var groupDetailProvider =
        Provider.of<GroupDetailProvider>(context, listen: false);
    var listLeds = groupDetailProvider.group.leds;
    var index = listLeds.indexWhere((element) => element.id == data['id']);
    listLeds[index] = listLeds[index].copyWith(
      temp: data['temp'],
      humi: data['humi'],
      brightness: data['brightness'],
      incli: data['incli'],
    );
    groupDetailProvider.updateData();
  }

  void addNewLed(
      BuildContext context, String name, double lat, double lon) async {
    var groupDetailProvider =
        Provider.of<GroupDetailProvider>(context, listen: false);
    final token = groupDetailProvider.token;
    http.Response res = await http.post(Uri.parse('${HOST}/led/data'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "name": name,
          "lat": lat,
          "lon": lon,
        }));
    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      Led item = Led.fromJson(body);
      groupDetailProvider.addLed(item);
    } else {
      groupDetailProvider.loadFailed();
    }
  }
}

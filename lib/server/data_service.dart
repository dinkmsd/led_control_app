import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:led_control_app/models/group.dart';
import 'package:led_control_app/models/led.dart';
import 'package:led_control_app/providers/data_provider.dart';
import 'package:led_control_app/utils/constant.dart';
import 'package:provider/provider.dart';

class DataService {
  void getData({required BuildContext context}) async {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    final token = dataProvider.token;
    http.Response res = await http.get(
      Uri.parse('${HOST}/group/list-group'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (res.statusCode == 200) {
      List<dynamic> data = json.decode(res.body);
      List<Group> allData = [];
      allData = data.map((json) => Group.fromJson(json)).toList();
      dataProvider.loadSuccessed(allData);
    } else {
      dataProvider.loadFailed();
    }
  }

  void updateData({required BuildContext context, required dynamic data}) {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.updateData(data);
  }

  void updateStatus(
      {required BuildContext context,
      required bool status,
      required int groupIdx}) async {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    final token = dataProvider.token;
    final groupId = dataProvider.groups[groupIdx].id;
    http.Response res =
        await http.post(Uri.parse('${HOST}/group/update-status'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode({"groupId": groupId, "status": status}));
    if (res.statusCode == 200) {
      dataProvider.updateStatus(groupIdx, status);
    } else {
      dataProvider.loadFailed();
    }
  }

  void updateAutoMode(
      {required BuildContext context,
      required bool status,
      required int groupIdx,
      required int ledIdx}) async {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    final token = dataProvider.token;
    final ledId = dataProvider.groups[groupIdx].leds[ledIdx].id;
    http.Response res = await http.patch(Uri.parse('${HOST}/led/update-mode'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({"ledId": ledId, "status": status}));
    print(res.body);
    if (res.statusCode == 200) {
      dataProvider.updateAutoMode(groupIdx, ledIdx, status);
    } else {
      dataProvider.loadFailed();
    }
  }

  void addNewLed(BuildContext context, String name, double lat, double lon,
      String groupId) async {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    final token = dataProvider.token;
    http.Response res = await http.post(Uri.parse('${HOST}/group/create-led'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
            {"name": name, "lat": lat, "lon": lon, "groupId": groupId}));
    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      Led item = Led.fromJson(body);
      dataProvider.addLed(item, groupId);
    } else {
      dataProvider.loadFailed();
    }
  }

  void modifyLumi(BuildContext context, String ledId, int value) async {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    final token = dataProvider.token;
    http.Response res = await http.patch(Uri.parse('${HOST}/led/brightness'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({"ledId": ledId, "value": value}));
    if (res.statusCode == 200) {
      // var body = json.decode(res.body);
      // print(body);
      // Led item = Led.fromJson(body);
      // dataProvider.addLed(item);
    } else {
      // dataProvider.loadFailed();
    }
  }

  void addNewGroup(String name, BuildContext context) async {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    final token = dataProvider.token;
    http.Response res = await http.post(Uri.parse('${HOST}/group/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({"nameGroup": name}));
    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      print(body);
      Group item = Group.fromJson(body);
      dataProvider.addGroup(item);
    } else {
      dataProvider.loadFailed();
    }
  }

  void deleteGroup(String groupId, BuildContext context) async {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    final token = dataProvider.token;
    http.Response res =
        await http.delete(Uri.parse('${HOST}/group/delete-group'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode({"groupId": groupId}));
    if (res.statusCode == 200) {
      dataProvider.deleteGroup(groupId);
    } else {
      dataProvider.loadFailed();
    }
  }
}

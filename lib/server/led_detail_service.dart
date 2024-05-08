import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:led_control_app/models/led.dart';
import 'package:led_control_app/providers/group_detail_provider.dart';
import 'package:led_control_app/providers/led_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LedDetailService {
  void getDetailLed(BuildContext context) async {
    var ledDetailProvider =
        Provider.of<LedDetailProvider>(context, listen: false);
    http.Response res =
        await http.post(Uri.parse('http://10.0.2.2:8080/group/detail-group'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${ledDetailProvider.token}'
            },
            body: jsonEncode({
              'ledId': ledDetailProvider.led.id,
            }));
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      Led ledDetal = Led.fromJson(data);
      ledDetailProvider.loadSuccessed(ledDetal);
    }
  }

  void updateData({required BuildContext context, required dynamic data}) {
    var ledDetailProvider =
        Provider.of<LedDetailProvider>(context, listen: false);
    ledDetailProvider.led;
    // print(data['brightness']);
    ledDetailProvider.led = ledDetailProvider.led.copyWith(
      temp: data['temp'],
      humi: data['humi'],
      brightness: data['brightness'],
      incli: data['incli'],
    );
    print(ledDetailProvider.led.toString());
    ledDetailProvider.updateData();
  }

  void addNewLed(
      BuildContext context, String name, double lat, double lon) async {
    var groupDetailProvider =
        Provider.of<GroupDetailProvider>(context, listen: false);
    final token = groupDetailProvider.token;
    http.Response res =
        await http.post(Uri.parse('http://10.0.2.2:8080/led/data'),
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

  void modifyLumi(BuildContext context, String ledId, int value) async {
    var ledDetailProvider =
        Provider.of<LedDetailProvider>(context, listen: false);
    final token = ledDetailProvider.token;
    http.Response res =
        await http.patch(Uri.parse('http://10.0.2.2:8080/led/brightness'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode({"ledId": ledId, "value": value}));
    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      print(body);
      Led item = Led.fromJson(body);
      ledDetailProvider.led = item;
      ledDetailProvider.updateData();
      // dataProvider.addLed(item);
    } else {
      // dataProvider.loadFailed();
    }
  }
}

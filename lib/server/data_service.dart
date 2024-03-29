import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:led_control_app/models/led_model.dart';
import 'package:led_control_app/providers/data_provider.dart';
import 'package:provider/provider.dart';

class DataService {
  void getData({required BuildContext context}) async {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    final token = dataProvider.token;
    http.Response res = await http.get(
      Uri.parse('http://10.0.2.2:8080/data'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (res.statusCode == 200) {
      List<dynamic> data = json.decode(res.body);
      List<LedInfo> allData = [];
      allData = data.map((json) => LedInfo.fromJson(json)).toList();
      dataProvider.loadSuccessed(allData);
    } else {
      dataProvider.loadFailed();
    }
  }

  void updateData({required BuildContext context, required dynamic data}) {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.updateData(data);
  }

  void addNewLed(
      BuildContext context, String name, String lat, String lon) async {
    var dataProvider = Provider.of<DataProvider>(context, listen: false);
    final token = dataProvider.token;
    http.Response res = await http
        .post(Uri.parse('http://10.0.2.2:8080/data'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    }, body: {
      "name": name,
      "lat": lat,
      "lon": lon,
    });
    if (res.statusCode == 200) {
      List<dynamic> data = json.decode(res.body);
      List<LedInfo> allData = [];
      allData = data.map((json) => LedInfo.fromJson(json)).toList();
      dataProvider.loadSuccessed(allData);
    } else {
      dataProvider.loadFailed();
    }
  }
}

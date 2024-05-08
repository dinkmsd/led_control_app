import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:led_control_app/models/group.dart';
import 'package:led_control_app/providers/group_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class GroupService {
  GroupService();

  void getListGroup({required BuildContext context, required}) async {
    var groupProvider = Provider.of<GroupProvider>(context, listen: false);
    http.Response res = await http.get(
      Uri.parse('http://10.0.2.2:8080/group/list-group'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${groupProvider.token}'
      },
    );
    if (res.statusCode == 200) {
      List<dynamic> data = json.decode(res.body);
      List<Group> listGroup = data.map((e) => Group.fromJson(e)).toList();
      groupProvider.loadSuccessed(listGroup);
    }
  }
}

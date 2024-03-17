import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:led_control_app/modules.dart';
import 'package:led_control_app/utlis.dart';

class MQTTDetailState with ChangeNotifier {
  MQTTConnectionState _detailConnectionState = MQTTConnectionState.connecting;
  LightInfo lightInfo;
  MQTTDetailState({required this.lightInfo});

  void handleData(String text) {
    Map<String, dynamic> jsonMap = json.decode(text);
    switch (jsonMap['action'] as String) {
      case 'detailData':
        updateData(jsonMap['item']);
        break;
    }
  }

  void updateData(Map<String, dynamic> dataJson) {
    lightInfo = LightInfo.fromJson(dataJson);
    notifyListeners();
  }

  void setAppConnectionState(MQTTConnectionState state) {
    _detailConnectionState = state;
    notifyListeners();
  }

  LightInfo get getLightInfo => lightInfo;
  MQTTConnectionState get getDetailConnectionState => _detailConnectionState;
}

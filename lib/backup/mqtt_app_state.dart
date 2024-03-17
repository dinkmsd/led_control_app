import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:led_control_app/modules.dart';
import 'package:led_control_app/utlis.dart';

class MQTTAppState with ChangeNotifier {
  MQTTConnectionState _appConnectionState = MQTTConnectionState.disconnected;
  String _receivedText = '';
  String _historyText = '';
  List<LightInfo> _allData = [];
  List<HistoryItem> _history = [];

  void handleData(String text) {
    Map<String, dynamic> jsonMap = json.decode(text);
    switch (jsonMap['action'] as String) {
      case 'recievedAllData':
        setAllData(jsonMap['listData']);
        break;
      case 'updatedData':
        updateData(jsonMap['historyData']);
        break;
    }
  }

  void setAllData(List<dynamic> dataJson) {
    _allData = dataJson.map((json) => LightInfo.fromJson(json)).toList();
    notifyListeners();
  }

  void updateData(List<dynamic> dataJson) {
    _history = dataJson.map((json) => HistoryItem.fromJson(json)).toList();
    notifyListeners();
  }

  void setReceivedText(String text) {
    _receivedText = text;
    _historyText = _receivedText;
    notifyListeners();
  }

  void setAppConnectionState(MQTTConnectionState state) {
    _appConnectionState = state;
    notifyListeners();
  }

  void setReceivedJson(Map<String, dynamic> dataJson) {}

  LightInfo _getLedDetail(String id) {
    LightInfo itemTarget = _allData.firstWhere(
      (item) => item.id == id,
    );
    return itemTarget;
  }

  String get getReceivedText => _receivedText;
  String get getHistoryText => _historyText;
  List<LightInfo> get getAllData => _allData;
  List<HistoryItem> get getHistory => _history;
  LightInfo Function(String id) get ledDetail => _getLedDetail;
  MQTTConnectionState get getAppConnectionState => _appConnectionState;
}

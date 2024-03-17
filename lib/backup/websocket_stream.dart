import 'dart:async';
import 'dart:convert';

import 'package:led_control_app/modules.dart';

class WebSocketStream {
  StreamController<List<LightInfo>> _streamController =
      StreamController<List<LightInfo>>();

  void handleData(String text) {
    Map<String, dynamic> jsonMap = json.decode(text);
    switch (jsonMap['action'] as String) {
      case 'recievedAllData':
        setAllData(jsonMap['listData']);
        break;
      // case 'updatedData':
      //   updateData(jsonMap['historyData']);
      //   break;
    }
  }

  void setAllData(List<dynamic> dataJson) {
    _streamController
        .add(dataJson.map((json) => LightInfo.fromJson(json)).toList());
  }

  Stream get listLed => _streamController.stream;
}

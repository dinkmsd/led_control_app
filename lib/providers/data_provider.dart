import 'package:flutter/material.dart';
import 'package:led_control_app/models/led_model.dart';

enum LoadingState { wating, success, fail }

class DataProvider extends ChangeNotifier {
  List<LedInfo> _items = [];
  LoadingState state = LoadingState.wating;
  String token;
  DataProvider({required this.token});
  List<LedInfo> get items => _items;

  void updateData(dynamic data) {
    var index = _items.indexWhere((element) => element.id == data['_id']);
    _items[index] = _items[index].copyWith(
        null,
        null,
        null,
        null,
        null,
        data['temp'],
        data['humi'],
        data['brightness'],
        data['incli'],
        null,
        null,
        null,
        null,
        null,
        null,
        null);
    notifyListeners();
  }

  void loadSuccessed(List<LedInfo> items) {
    _items = items;
    state = LoadingState.success;
    notifyListeners();
  }

  void addLed(LedInfo item) {
    _items.add(item);
    notifyListeners();
  }

  void loadFailed() {
    state = LoadingState.fail;
    notifyListeners();
  }

  void loading() {
    state = LoadingState.wating;
    notifyListeners();
  }
}

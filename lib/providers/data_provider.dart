import 'package:flutter/material.dart';
import 'package:led_control_app/models/group.dart';
import 'package:led_control_app/models/history.dart';
import 'package:led_control_app/models/led.dart';
import 'package:led_control_app/models/schedule.dart';
import 'package:led_control_app/utils/patten.dart';

class DataProvider extends ChangeNotifier {
  List<Group> _groups = [];
  LoadingState state = LoadingState.wating;
  String token;
  DataProvider({required this.token});
  List<Group> get groups => _groups;

  void updateData(dynamic data) {
    print(data);
    var groupIndex =
        _groups.indexWhere((element) => element.id == data['group']);
    var ledIndex = _groups[groupIndex]
        .leds
        .indexWhere((element) => element.id == data['id']);

    _groups[groupIndex].leds[ledIndex] =
        _groups[groupIndex].leds[ledIndex].copyWith(
              temp: data['temp'],
              humi: data['humi'],
              brightness: data['brightness'],
              incli: data['incli'],
            );
    notifyListeners();
  }

  void loadSuccessed(List<Group> groups) {
    _groups = groups;
    state = LoadingState.success;
    print("Success");
    notifyListeners();
  }

  void addLed(Led item, String groupId) {
    (_groups.firstWhere((element) => element.id == groupId)).leds.add(item);
    notifyListeners();
  }

  void addSchedule(Schedule item, String groupId, String ledId) {
    var groupIndex = _groups.indexWhere((element) => element.id == groupId);
    var ledIndex =
        _groups[groupIndex].leds.indexWhere((element) => element.id == ledId);
    _groups[groupIndex].leds[ledIndex].schedules.add(item);
  }

  void addHistory(History item, String groupId, String ledId) {
    var groupIndex = _groups.indexWhere((element) => element.id == groupId);
    var ledIndex =
        _groups[groupIndex].leds.indexWhere((element) => element.id == ledId);
    _groups[groupIndex].leds[ledIndex].histories.add(item);
  }

  void updateLumi() {}

  void loadFailed() {
    state = LoadingState.fail;
    notifyListeners();
  }

  void loading() {
    state = LoadingState.wating;
    notifyListeners();
  }
}

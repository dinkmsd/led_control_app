import 'package:flutter/material.dart';
import 'package:led_control_app/models/schedule.dart';
import 'package:led_control_app/utils/patten.dart';

class ScheduleProvider extends ChangeNotifier {
  String id;
  List<Schedule> schedules = [];
  String token;
  LoadingState state = LoadingState.wating;
  String timeString = '';
  ScheduleProvider({required this.id, required this.token});

  void loadSuccessed(List<Schedule> schedules) {
    this.schedules = schedules;
    state = LoadingState.success;
    notifyListeners();
  }

  void loadFailed() {
    schedules = [];
    state = LoadingState.fail;
    notifyListeners();
  }

  void loading() {
    state = LoadingState.wating;
    notifyListeners();
  }

  void setTimer(String time) {
    timeString = time;
    notifyListeners();
  }
}

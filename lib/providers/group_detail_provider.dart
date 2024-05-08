import 'package:flutter/material.dart';
import 'package:led_control_app/models/group.dart';
import 'package:led_control_app/models/led.dart';
import 'package:led_control_app/utils/patten.dart';

class GroupDetailProvider extends ChangeNotifier {
  final String token;
  Group group;

  LoadingState state = LoadingState.wating;

  GroupDetailProvider({required this.token, required this.group});
  void loadSuccessed(Group group) {
    this.group = group;
    state = LoadingState.success;
    notifyListeners();
  }

  void updateData() {
    state = LoadingState.success;
    notifyListeners();
  }

  void addLed(Led item) {
    group.leds.add(item);
    notifyListeners();
  }

  void loadFailed() {
    state = LoadingState.fail;
    notifyListeners();
  }
}

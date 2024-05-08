import 'package:flutter/material.dart';
import 'package:led_control_app/models/led.dart';
import 'package:led_control_app/utils/patten.dart';

class LedDetailProvider extends ChangeNotifier {
  final String token;
  Led led;

  LoadingState state = LoadingState.wating;

  LedDetailProvider({required this.token, required this.led});
  void loadSuccessed(Led led) {
    this.led = led;
    state = LoadingState.success;
    notifyListeners();
  }

  void updateData() {
    state = LoadingState.success;
    notifyListeners();
  }

  void loadFailed() {
    state = LoadingState.fail;
    notifyListeners();
  }
}

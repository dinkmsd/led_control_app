import 'package:flutter/material.dart';
import 'package:led_control_app/models/notification_model.dart';
import 'package:led_control_app/utils/patten.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> notifications = [];
  String token;
  LoadingState state = LoadingState.wating;
  String timeString = '';
  NotificationProvider({required this.token});

  void loadSuccessed(List<NotificationModel> notifications) {
    this.notifications = notifications;
    state = LoadingState.success;
    notifyListeners();
  }

  void loadFailed() {
    notifications = [];
    state = LoadingState.fail;
    notifyListeners();
  }

  void loading() {
    state = LoadingState.wating;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:led_control_app/models/group.dart';
import 'package:led_control_app/utils/patten.dart';

class GroupProvider extends ChangeNotifier {
  final String token;
  GroupProvider({required this.token});
  List<Group> _items = [];
  LoadingState state = LoadingState.wating;
  List<Group> get items => _items;

  void updateData(dynamic data) {
    notifyListeners();
  }

  void loadSuccessed(List<Group> items) {
    _items = items;
    state = LoadingState.success;
    notifyListeners();
  }

  void addLed(Group item) {
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

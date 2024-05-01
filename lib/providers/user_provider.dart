import 'package:flutter/material.dart';
import 'package:led_control_app/models/user_model.dart';

enum AppAuthState { wating, login, register, loged }

class UserProvider extends ChangeNotifier {
  String _token = '';

  AppAuthState state = AppAuthState.loged;

  User _user = User(
    id: '',
    name: '',
    username: '',
    token: '',
    role: -1,
  );

  String get token => _token;
  User get user => _user;

  void setLogin() {
    _token = '';
    state = AppAuthState.login;
    notifyListeners();
  }

  void setRegister() {
    state = AppAuthState.register;
    notifyListeners();
  }

  void setHome(String token) {
    _token = token;
    state = AppAuthState.loged;
    notifyListeners();
  }

  void setUser(dynamic user) {
    _user = User(
      id: user['id'] ?? '',
      name: user['name'] ?? '',
      username: user['username'] ?? '',
      token: user['token'] ?? '',
      role: user['role'] ?? -1,
    );
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:led_control_app/models/user_model.dart';

enum AppAuthState { wating, login, register, loged }

class UserProvider extends ChangeNotifier {
  String _token = '';

  AppAuthState state = AppAuthState.wating;

  User _user = User(
    id: '',
    username: '',
    email: '',
    token: '',
    password: '',
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

  void setUser(String body) {
    var data = json.decode(body)['data'];
    _user = User(
      id: data['id'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      token: data['token'] ?? '',
      password: '',
    );
    // notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}

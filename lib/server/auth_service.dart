import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:led_control_app/models/user_model.dart';
import 'package:led_control_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void registerUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        username: name,
        password: password,
        email: email,
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('http://10.0.2.2:8080/register'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final body = json.decode(res.body);
      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['msg'])));
      } else if (res.statusCode == 201) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['msg'])));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void loginUser({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
        Uri.parse('http://10.0.2.2:8080/login'),
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var body = json.decode(res.body);
      if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        userProvider.setUser(res.body);
        String token = body['data']['token'];
        await prefs.setString('x-auth-token', token);
        print(body['data']);
        userProvider.setUser(body['data']);
        userProvider.setHome(token);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['msg'])));
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('http://10.0.2.2:8080/token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!,
        },
      );

      if (tokenRes.statusCode == 200) {
        userProvider.setUser(tokenRes.body);
        userProvider.setHome(token);
        return;
        // userProvider.setUser(body['data']);
      } else if (tokenRes.statusCode == 201) {
        prefs.setString('x-auth-token', '');
      }
      userProvider.setLogin();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void signOut(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    userProvider.setLogin();
  }

  void navigateToRegister(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setRegister();
  }

  void navigateToLogin(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setLogin();
  }
}

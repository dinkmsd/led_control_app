import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:led_control_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:led_control_app/utils/constant.dart';

class AuthService {
  void registerUser({
    required BuildContext context,
    required String name,
    required String username,
    required String password,
  }) async {
    try {
      dynamic user = {
        name: name,
        username: username,
        password: password,
      };
      http.Response res = await http.post(
        Uri.parse('${HOST}/auth/register'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final body = json.decode(res.body);
      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['message'])));
      } else if (res.statusCode == 201) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['message'])));
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
        Uri.parse('${HOST}/auth/login'),
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
        userProvider.setUser(body['user']);
        String token = body['token'];
        await prefs.setString('token', token);
        userProvider.setHome(token);
        final _firebaseMessaging = FirebaseMessaging.instance;
        _firebaseMessaging.requestPermission();
        FirebaseMessaging.instance.getToken().then((value) async {
          String? fcmToken = value;
          print(fcmToken);
          var res = await http.patch(
              Uri.parse('${HOST}/users/update-fcm-token/${body['user']['id']}'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token'
              },
              body: jsonEncode({"oldToken": "", "newToken": fcmToken}));
          print(res.body);
        });
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(body['message'])));
      }
    } catch (e) {
      debugPrint("AuthService: $e");

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
      var token = prefs.getString('token');
      if (token == null) {
        prefs.setString('token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('${HOST}/auth/token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (tokenRes.statusCode == 200) {
        var userData = json.decode(tokenRes.body);
        debugPrint('$userData');
        userProvider.setUser(userData);
        userProvider.setHome(token!);
        return;
      } else {
        if (tokenRes.statusCode == 401) prefs.setString('token', '');
        userProvider.loadFailed();
      }
      userProvider.setLogin();
    } catch (e) {
      debugPrint('Error: $e');
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

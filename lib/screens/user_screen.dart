import 'package:flutter/material.dart';
import 'package:led_control_app/providers/user_provider.dart';
import 'package:led_control_app/server/auth_service.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthService().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
        actions: [
          IconButton(
              onPressed: () => signOutUser(context),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.grey,
            minRadius: 60,
            child: Icon(
              Icons.person,
              size: 90,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            user.username,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

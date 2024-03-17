import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:led_control_app/app_color.dart';
import 'package:led_control_app/home_screen.dart';
import 'package:led_control_app/map_screen.dart';
import 'package:led_control_app/modules.dart';
import 'package:led_control_app/screens/user_screen.dart';
import 'package:led_control_app/web_socket_controller.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: AppColors.backgroundPrimary,
          // appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[900])
        ),
        home: const NavigationExample());
  }
}

class Test extends StatelessWidget {
  Test({super.key});

  final item = LightInfo(
      id: '6566aec06d2075526cfe1331',
      name: "LED 3",
      lat: 10.876264682056627,
      lon: 106.8045361629442,
      temp: 30,
      humi: 70,
      brightness: 30,
      history: [],
      schedule: []);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  // late MQTTController mqttController;
  late WebSocketManager manager;

  @override
  void initState() {
    // TODO: implement initState
    _connectToServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<LightInfo>>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          var items = snapshot.data;
          return Scaffold(
            bottomNavigationBar: SalomonBottomBar(
              currentIndex: currentPageIndex,
              onTap: (i) => setState(() => currentPageIndex = i),
              items: [
                /// Home
                SalomonBottomBarItem(
                  icon: const Icon(Icons.home),
                  title: const Text("Home"),
                  selectedColor: Colors.purple,
                ),

                /// Map
                SalomonBottomBarItem(
                  icon: const Icon(Icons.map_outlined),
                  title: const Text("Map"),
                  selectedColor: Colors.pink,
                ),

                SalomonBottomBarItem(
                  icon: const Icon(Icons.person),
                  title: const Text("User"),
                  selectedColor: Colors.orange,
                ),
              ],
            ),
            body: <Widget>[
              /// Home page
              HomeScreen(items: items ?? []),

              /// Map page
              MapScreen(items: items ?? []),

              // User page
              const UserScreen(),
            ][currentPageIndex],
          );
        });
  }

  final StreamController<List<LightInfo>> _streamController =
      StreamController<List<LightInfo>>();

  void _connectToServer() {
    manager = WebSocketManager(
        serverUrl: "ws://10.0.2.2:8080",
        onData: (value) {
          print("Data comming:");
          print(value as String);
          Map<String, dynamic> jsonMap = json.decode(value);
          switch (jsonMap['action'] as String) {
            case 'recievedAllData':
              {
                List<LightInfo> _allData = [];
                List<dynamic> dataJson = jsonMap['listData'];
                _allData =
                    dataJson.map((json) => LightInfo.fromJson(json)).toList();
                _streamController.add(_allData);
              }
          }
        },
        onError: (error) {
          print("Error !!!");
          print(error as String);
        },
        onConnected: () {
          print("Connected");
          const initData = {"action": "getData"};
          manager.sendMessage(initData);
        },
        onDisconnected: () {
          print("Disconnected");
        });
    manager.connect();
  }
}

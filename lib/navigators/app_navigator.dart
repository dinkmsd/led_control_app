import 'package:flutter/material.dart';
import 'package:led_control_app/screens/home_screen.dart';
import 'package:led_control_app/screens/map_screen.dart';
import 'package:led_control_app/screens/notification_screen.dart';
import 'package:led_control_app/screens/user_screen.dart';
import 'package:led_control_app/utils/app_color.dart';
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

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

          /// Notification page
          SalomonBottomBarItem(
            icon: const Icon(Icons.notifications),
            title: const Text("Notification"),
            selectedColor: Colors.green,
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
        const HomeScreen(),

        /// Map page
        const MapScreen(),

        /// Notification page
        const NotificationScreen(),

        // User page
        const UserScreen(),
      ][currentPageIndex],
    );
  }
}

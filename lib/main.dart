import 'package:flutter/material.dart';
import 'package:led_control_app/navigators/app_navigator.dart';
import 'package:led_control_app/providers/data_provider.dart';
import 'package:led_control_app/providers/user_provider.dart';
import 'package:led_control_app/screens/login_screen.dart';
import 'package:led_control_app/screens/register_screen.dart';
import 'package:led_control_app/server/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  final _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print(token);
    });
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: Color(0xFFF6F8FB)),
      home: Consumer<UserProvider>(
        builder: (context, currentState, child) {
          if (currentState.state == AppAuthState.login) {
            return const LoginScreen();
          }

          if (currentState.state == AppAuthState.register) {
            return const RegisterScreen();
          }

          if (currentState.state == AppAuthState.loged) {
            return ChangeNotifierProvider(
              create: (_) => DataProvider(token: currentState.token),
              child: const AppNavigator(),
            );
          }

          if (currentState.state == AppAuthState.failed) {
            return Center(
              child: Column(
                children: [
                  Text('Network Failed!!!'),
                  ElevatedButton(
                      onPressed: () {
                        currentState.loading();
                        authService.getUserData(context);
                      },
                      child: Text('Reload'))
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

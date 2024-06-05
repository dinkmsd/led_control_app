import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:led_control_app/providers/notification_provider.dart';
import 'package:led_control_app/screens/map_repair_screen.dart';
import 'package:led_control_app/server/notification_service.dart';
import 'package:led_control_app/utils/patten.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationService notificationService = NotificationService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService.getNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: Consumer<NotificationProvider>(builder: (context, state, child) {
        if (state.state == LoadingState.success) {
          var items = state.notifications;
          return ListView.separated(
            separatorBuilder: (_, __) {
              return SizedBox(
                height: 9,
              );
            },
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MapRepairScreen(
                              location: LatLng(
                                  state.notifications[index].led.lat,
                                  state.notifications[index].led.lon))));
                },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 0.5,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  margin: EdgeInsets.symmetric(horizontal: 9),
                  child: Padding(
                    padding: contentPadding,
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors.amber[400],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: items[index].led.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                      text:
                                          ' have some problem, please check and repair it')
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        if (state.state == LoadingState.fail) {
          return Center(
            child: Text('Load failed'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

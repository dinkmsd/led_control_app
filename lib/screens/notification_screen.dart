import 'package:flutter/material.dart';
import 'package:led_control_app/components/group_led_widget.dart';
import 'package:led_control_app/utils/patten.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: Padding(
        padding: contentPadding,
        child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 10),
            itemCount: 10,
            separatorBuilder: (_, __) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (context, index) {
              return const GroupLedWidget(
                ledNums: 10,
                ledActive: 10,
                ledError: 0,
                groupName: 'ABC',
              );
            }),
      ),
    );
  }
}

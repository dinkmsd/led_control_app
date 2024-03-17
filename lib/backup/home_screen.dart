import 'package:flutter/material.dart';
import 'package:led_control_app/led_info_item_widget.dart';
import 'package:led_control_app/modules.dart';
import 'package:led_control_app/utlis.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  List<LightInfo> items;
  HomeScreen({super.key, required this.items});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: widget.items.isEmpty
            ? const Center(
                child: Text(
                  'Home page',
                ),
              )
            : Padding(
                padding: contentPadding,
                child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 10),
                    itemCount: widget.items.length,
                    separatorBuilder: (_, __) => const SizedBox(
                          height: 10,
                        ),
                    itemBuilder: (context, index) {
                      return LedInfoItemWidget(item: widget.items[index]);
                    }),
              ));
  }
}

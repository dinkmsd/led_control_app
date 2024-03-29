import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:led_control_app/components/led_info_item_widget.dart';
import 'package:led_control_app/controllers/web_socket_controller.dart';
import 'package:led_control_app/providers/data_provider.dart';
import 'package:led_control_app/server/data_service.dart';
import 'package:led_control_app/utils/custom_textfield.dart';
import 'package:led_control_app/utils/patten.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataService dataService = DataService();

  late WebSocketManager webSocketManager;
  @override
  void initState() {
    dataService.getData(context: context);
    webSocketManager = WebSocketManager(
        serverUrl: "ws://10.0.2.2:8080",
        onData: (value) {
          var res = json.decode(value);
          if (res['action'] == 'update') {
            var data = res['data'];
            dataService.updateData(context: context, data: data);
          }
        },
        onError: (error) {
          print("Error !!!");
          print(error as String);
        },
        onConnected: () {
          print("Connected");
        },
        onDisconnected: () {
          print("Disconnected");
        });
    webSocketManager.connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
                onPressed: () {
                  var dataProvider =
                      Provider.of<DataProvider>(context, listen: false);
                  final nameTextController = TextEditingController();
                  final latTextController = TextEditingController();
                  final lonTextController = TextEditingController();
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15))),
                    context: context,
                    builder: (BuildContext context) {
                      return ChangeNotifierProvider.value(
                        value: dataProvider,
                        child: Consumer<DataProvider>(
                            builder: (context, state, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15))),
                                padding: contentPadding,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: () {},
                                            child: const Text('Cancel')),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.ios_share)),
                                      ],
                                    ),
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Add Led',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: CustomTextField(
                                        controller: nameTextController,
                                        hintText: 'Enter led name',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: CustomTextField(
                                        controller: latTextController,
                                        hintText: 'Enter latitude',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: CustomTextField(
                                        controller: lonTextController,
                                        hintText: 'Enter longitude',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: SizedBox(
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 3 / 4,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      // Add led handler
                                      dataService.addNewLed(
                                          context,
                                          nameTextController.text,
                                          latTextController.text,
                                          lonTextController.text);
                                    },
                                    label: const Text(
                                      "Add",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    icon: const Icon(
                                      Icons.add_box_outlined,
                                      color: Colors.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF007AFF),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: contentPadding,
          child: Consumer<DataProvider>(builder: (context, state, child) {
            if (state.state == LoadingState.wating) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var items = state.items;
            if (items.isEmpty) {
              return const Center(
                child: Text(
                  'Empty',
                ),
              );
            }
            return ListView.separated(
                padding: const EdgeInsets.only(bottom: 10),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(
                      height: 10,
                    ),
                itemBuilder: (context, index) {
                  return LedInfoItemWidget(item: items[index]);
                });
          }),
        ));
  }
}

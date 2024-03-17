import 'package:flutter/material.dart';
import 'package:led_control_app/app_color.dart';
import 'package:led_control_app/modules.dart';
import 'package:led_control_app/mqtt_app_state.dart';
import 'package:led_control_app/mqtt_controller.dart';
import 'package:led_control_app/mqtt_detail_state.dart';
import 'package:led_control_app/slider_widget.dart';
import 'package:led_control_app/utlis.dart';
import 'package:led_control_app/web_socket_controller.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.item});
  final LightInfo item;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late MQTTController mqttItemController;

  late WebSocketManager manager;

  @override
  Widget build(BuildContext context) {
    return Consumer<MQTTAppState>(
      builder: (context, currentState, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.item.name),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.schedule))
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: detailInfoWidget(
                            'Temperature',
                            Icons.device_thermostat,
                            [
                              Text(
                                '${widget.item.temp.toString()} °C',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                            AppColors.gradientRed),
                      ),
                      Expanded(
                        child: detailInfoWidget(
                            'Humidity',
                            Icons.water_drop,
                            [
                              Text(
                                '${widget.item.humi.toString()} %',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                            AppColors.gradientBlue),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: detailInfoWidget(
                            'Inclination',
                            Icons.text_rotation_angledown,
                            [
                              Text(
                                'x: ${widget.item.x.toString()}',
                                style: inclinationStyle,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                'y: ${widget.item.y.toString()}',
                                style: inclinationStyle,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                'z: ${widget.item.z.toString()}',
                                style: inclinationStyle,
                              ),
                            ],
                            AppColors.gradientGreen),
                      ),
                      Expanded(
                        child: detailInfoWidget(
                            'Network',
                            Icons.network_check,
                            [
                              Text(
                                'RSRP: ${widget.item.rsrp.toString()}',
                                style: networkStyle,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Cell ID: ${widget.item.cellID.toString()}',
                                style: networkStyle,
                              ),
                            ],
                            AppColors.gradientPurple),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SliderWidget(
                      onChange: (value) {},
                      onChangeEnd: (value) {
                        var request = {
                          "action": "modifyBrightness",
                          "id": widget.item.id,
                          "value": value.round()
                        };
                        mqttItemController.publish(request,
                            topic: "dinkmsd/server");
                      },
                      initialValue: widget.item.brightness?.toDouble() ?? 0,
                    ),
                  ),
                ],
              )),
        );

        // final item = currentState.ledDetail(widget.id);
        // return Scaffold(
        //   appBar: AppBar(
        //     title: Text(item.name),
        //     actions: [
        //       IconButton(onPressed: () {}, icon: const Icon(Icons.schedule))
        //     ],
        //   ),
        //   body: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Column(
        //         children: [
        //           Row(
        //             children: [
        //               Expanded(
        //                 child: detailInfoWidget(
        //                     'Temperature',
        //                     Icons.device_thermostat,
        //                     [
        //                       Text(
        //                         '${item.temp.toString()} °C',
        //                         style: const TextStyle(
        //                             fontSize: 18,
        //                             fontWeight: FontWeight.w500,
        //                             color: Colors.white),
        //                       )
        //                     ],
        //                     AppColors.gradientRed),
        //               ),
        //               Expanded(
        //                 child: detailInfoWidget(
        //                     'Humidity',
        //                     Icons.water_drop,
        //                     [
        //                       Text(
        //                         '${item.humi.toString()} %',
        //                         style: const TextStyle(
        //                             fontSize: 18,
        //                             fontWeight: FontWeight.w500,
        //                             color: Colors.white),
        //                       )
        //                     ],
        //                     AppColors.gradientBlue),
        //               ),
        //             ],
        //           ),
        //           Row(
        //             children: [
        //               Expanded(
        //                 child: detailInfoWidget(
        //                     'Inclination',
        //                     Icons.text_rotation_angledown,
        //                     [
        //                       Text(
        //                         'x: ${item.x.toString()}',
        //                         style: inclinationStyle,
        //                       ),
        //                       const SizedBox(
        //                         height: 3,
        //                       ),
        //                       Text(
        //                         'y: ${item.y.toString()}',
        //                         style: inclinationStyle,
        //                       ),
        //                       const SizedBox(
        //                         height: 3,
        //                       ),
        //                       Text(
        //                         'z: ${item.z.toString()}',
        //                         style: inclinationStyle,
        //                       ),
        //                     ],
        //                     AppColors.gradientGreen),
        //               ),
        //               Expanded(
        //                 child: detailInfoWidget(
        //                     'Network',
        //                     Icons.network_check,
        //                     [
        //                       Text(
        //                         'RSRP: ${item.rsrp.toString()}',
        //                         style: networkStyle,
        //                       ),
        //                       const SizedBox(
        //                         height: 3,
        //                       ),
        //                       Text(
        //                         'Cell ID: ${item.cellID.toString()}',
        //                         style: networkStyle,
        //                       ),
        //                     ],
        //                     AppColors.gradientPurple),
        //               ),
        //             ],
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           Center(
        //             child: SliderWidget(
        //               onChange: (value) {},
        //               onChangeEnd: (value) {
        //                 var request = {
        //                   "action": "modifyBrightness",
        //                   "id": item.id,
        //                   "value": value.round()
        //                 };
        //                 mqttItemController.publish(request,
        //                     topic: "dinkmsd/server");
        //               },
        //               initialValue: item.brightness?.toDouble() ?? 0,
        //             ),
        //           ),
        //         ],
        //       )),
        // );
      },
    );
  }

  Widget detailInfoWidget(String title, IconData icon, List<Widget> widgets,
      List<Color> listColors) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(9.0),
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: listColors,
          ),
          borderRadius: BorderRadius.circular(9)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.white),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgets,
              )
            ],
          )
        ],
      ),
    );
  }

  void _configureAndConnect(MQTTDetailState currentState) async {
    mqttItemController = MQTTController(
        host: "broker.emqx.io",
        topic: "dinkmsd/${currentState.getLightInfo.id}",
        identifier: "dinkmsd_abs",
        handleRequest: (message, topic) {
          if (topic == "dinkmsd/${currentState.getLightInfo.id}") {
            currentState.handleData(message);
          }
        },
        handleState: (state) {
          if (currentState.getDetailConnectionState != state) {
            currentState.setAppConnectionState(state);
          }
        });

    mqttItemController.initializeMQTTClient();

    await mqttItemController.connect();
    var initData = {
      "action": "requestDetail",
      "id": currentState.getLightInfo.id
    };
    mqttItemController.publish(initData, topic: "dinkmsd/server");
  }

  void _connectToServer(BuildContext context, MQTTDetailState currentAppState) {
    manager = WebSocketManager(
        serverUrl: "ws://10.0.2.2:8080",
        onData: (value) {
          print("Co data");
          print(value as String);
          currentAppState.handleData(value);
        },
        onError: (error) {
          print("Loi roi!!!!");
          print(error as String);
        },
        onConnected: () {
          print("Da ket noi");
          var initData = {
            "action": "requestDetail",
            "id": currentAppState.getLightInfo.id
          };
          manager.sendMessage(initData);
          // currentAppState.setAppConnectionState(MQTTConnectionState.connected);
        },
        onDisconnected: () {
          print("Da ngat ket noi");
        });
    manager.connect();
  }
}

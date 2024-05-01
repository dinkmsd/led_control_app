import 'package:flutter/material.dart';
import 'package:led_control_app/components/slider_widget.dart';
import 'package:led_control_app/providers/data_provider.dart';
import 'package:led_control_app/providers/schedule_provider.dart';
import 'package:led_control_app/providers/user_provider.dart';
import 'package:led_control_app/screens/schedule_screen.dart';
import 'package:led_control_app/utils/app_color.dart';
import 'package:led_control_app/utils/patten.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  final String ledID;
  const DetailScreen({super.key, required this.ledID});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late UserProvider userProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, state, child) {
      var items = state.items;
      var item = items.firstWhere((element) => element.id == widget.ledID);
      return Scaffold(
        appBar: AppBar(
          title: Text(item.name),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                          create: (_) =>
                              ScheduleProvider(id: item.id, token: state.token),
                          child: const ScheduleScreen()),
                    ),
                  );
                },
                icon: const Icon(Icons.schedule))
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
                              '${item.temp.toString()} °C',
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
                              '${item.humi.toString()} %',
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
                              'x: ${item.x.toString()}',
                              style: inclinationStyle,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'y: ${item.y.toString()}',
                              style: inclinationStyle,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'z: ${item.z.toString()}',
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
                              'RSRP: ${item.rsrp.toString()}',
                              style: networkStyle,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Cell ID: ${item.cellID.toString()}',
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
                      // Push request
                    },
                    initialValue: item.brightness?.toDouble() ?? 0,
                  ),
                ),
              ],
            )),
      );
    });
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
}

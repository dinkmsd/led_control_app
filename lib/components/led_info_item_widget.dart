import 'package:flutter/material.dart';
import 'package:led_control_app/providers/data_provider.dart';
import 'package:led_control_app/screens/detail_screen.dart';
import 'package:led_control_app/utils/app_color.dart';
import 'package:led_control_app/utils/patten.dart';
import 'package:provider/provider.dart';

class LedInfoItemWidget extends StatelessWidget {
  final int groupIdx;
  final int ledIdx;
  const LedInfoItemWidget(
      {super.key, required this.groupIdx, required this.ledIdx});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
                value: dataProvider,
                child: DetailScreen(
                  groupIdx: groupIdx,
                  ledIdx: ledIdx,
                )),
          ),
        );
      },
      child: Container(
        // padding: contentPadding,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(boxShadow: const [
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
        ], borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          children: [
            Container(
              padding: contentPadding,
              decoration: BoxDecoration(
                  color: dataProvider.groups[groupIdx].leds[ledIdx].status
                      ? Color.fromARGB(255, 112, 252, 77)
                      : Color.fromARGB(255, 252, 77, 77),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dataProvider.groups[groupIdx].leds[ledIdx].name,
                    style: TextStyle(
                        color: dataProvider.groups[groupIdx].leds[ledIdx].status
                            ? AppColors.textCustomColor
                            : Color.fromARGB(255, 248, 211, 118),
                        fontWeight: FontWeight.w500),
                  ),
                  Icon(Icons.arrow_circle_right_outlined,
                      color: dataProvider.groups[groupIdx].leds[ledIdx].status
                          ? AppColors.textCustomColor
                          : Color.fromARGB(255, 248, 211, 118))
                ],
              ),
            ),
            Padding(
              padding: contentPadding,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    detailInfoWidget(
                        "Temp",
                        Icons.device_thermostat,
                        dataProvider.groups[groupIdx].leds[ledIdx].temp != null
                            ? '${dataProvider.groups[groupIdx].leds[ledIdx].temp}°C'
                            : '-'),
                    const VerticalDivider(thickness: 1),
                    detailInfoWidget(
                        "Humi",
                        Icons.water_drop,
                        dataProvider.groups[groupIdx].leds[ledIdx].humi != null
                            ? '${dataProvider.groups[groupIdx].leds[ledIdx].humi}%'
                            : '-'),
                    const VerticalDivider(thickness: 1),
                    detailInfoWidget(
                        "Lumi",
                        Icons.light_mode,
                        dataProvider.groups[groupIdx].leds[ledIdx].brightness !=
                                null
                            ? '${dataProvider.groups[groupIdx].leds[ledIdx].brightness}%'
                            : '-'),
                    const VerticalDivider(thickness: 1),
                    detailInfoWidget(
                        "Incli",
                        Icons.text_rotation_angledown,
                        dataProvider.groups[groupIdx].leds[ledIdx].incli != null
                            ? '${dataProvider.groups[groupIdx].leds[ledIdx].incli}°'
                            : '-'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailInfoWidget(String title, IconData icon, String value) {
    return Expanded(
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  color: AppColors.iconCustomColor,
                ),
                Text(
                  value,
                  style: textColorBlack,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

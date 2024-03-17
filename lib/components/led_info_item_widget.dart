import 'package:flutter/material.dart';
import 'package:led_control_app/models/led_model.dart';
import 'package:led_control_app/providers/data_provider.dart';
import 'package:led_control_app/screens/detail_screen.dart';
import 'package:led_control_app/utils/app_color.dart';
import 'package:led_control_app/utils/patten.dart';
import 'package:provider/provider.dart';

class LedInfoItemWidget extends StatelessWidget {
  final LedInfo item;
  const LedInfoItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var dataProvider = Provider.of<DataProvider>(context, listen: false);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
                value: dataProvider,
                child: DetailScreen(
                  ledID: item.id,
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
              decoration: const BoxDecoration(
                  color: Color(0xFFFCD64D),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                        color: AppColors.textCustomColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const Icon(Icons.arrow_circle_right_outlined,
                      color: AppColors.textCustomColor)
                ],
              ),
            ),
            Padding(
              padding: contentPadding,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    detailInfoWidget("Temp", Icons.device_thermostat,
                        item.temp != null ? '${item.temp}°C' : '-'),
                    const VerticalDivider(thickness: 1),
                    detailInfoWidget("Humi", Icons.water_drop,
                        item.humi != null ? '${item.humi}%' : '-'),
                    const VerticalDivider(thickness: 1),
                    detailInfoWidget("Lumi", Icons.light_mode,
                        item.brightness != null ? '${item.brightness}%' : '-'),
                    const VerticalDivider(thickness: 1),
                    detailInfoWidget("Incli", Icons.text_rotation_angledown,
                        item.incli != null ? '${item.incli}°' : '-'),
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

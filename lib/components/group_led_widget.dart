import 'package:flutter/material.dart';
import 'package:led_control_app/providers/data_provider.dart';
import 'package:led_control_app/screens/home_screen.dart';
import 'package:led_control_app/utils/app_color.dart';
import 'package:led_control_app/utils/patten.dart';
import 'package:provider/provider.dart';

class GroupLedWidget extends StatelessWidget {
  final String groupName;
  final int ledNums;
  final int ledActive;
  final int ledError;
  const GroupLedWidget(
      {super.key,
      required this.groupName,
      required this.ledNums,
      required this.ledActive,
      required this.ledError});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var dataProvider = Provider.of<DataProvider>(context, listen: false);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
                value: dataProvider, child: const HomeScreen()),
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
                    groupName,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 14, 37, 139),
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
                    detailInfoWidget("Leds", Icons.lightbulb, '${ledNums}'),
                    const VerticalDivider(thickness: 1),
                    detailInfoWidget(
                        "Active", Icons.run_circle, '${ledActive}'),
                    const VerticalDivider(thickness: 1),
                    detailInfoWidget("Error", Icons.error, '${ledError}'),
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

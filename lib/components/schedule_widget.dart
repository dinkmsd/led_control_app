import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:led_control_app/providers/schedule_provider.dart';
import 'package:led_control_app/providers/user_provider.dart';
import 'package:led_control_app/server/schedule_service.dart';
import 'package:led_control_app/utils/app_color.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ScheduleWidget extends StatefulWidget {
  int scheIdx;
  ScheduleWidget({super.key, required this.scheIdx});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  late UserProvider userProvider;
  late DateTime dateTimeFormat;
  late ScheduleProvider scheduleProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    scheduleProvider = Provider.of<ScheduleProvider>(context, listen: false);
  }

  DateTime covertDateString(String dateString) {
    var s = dateString.split(' ');
    var hhmm = s[0].split(':');
    switch (s[1]) {
      case 'AM':
        return DateTime(2024, 1, 1, int.parse(hhmm[0]), int.parse(hhmm[1]));
      case 'PM':
        {
          var hh = int.parse(hhmm[0]);
          if (hh == 12) {
            return DateTime(2024, 1, 1, int.parse(hhmm[0]), int.parse(hhmm[1]));
          }
          hh += 12;
          if (hh == 24) hh = 0;
          return DateTime(2024, 1, 1, hh, int.parse(hhmm[1]));
        }
    }
    return DateTime.now();
  }

  ScheduleService scheduleService = ScheduleService();
  @override
  Widget build(BuildContext context) {
    var _dateFormat =
        this.covertDateString(scheduleProvider.schedules[widget.scheIdx].time);
    String hhmm = DateFormat('hh:mm ').format(_dateFormat);
    String aa = DateFormat('aa').format(_dateFormat);
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
      decoration: BoxDecoration(
        color: AppColors.buttonCustomColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: hhmm,
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    TextSpan(
                        text: aa, style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Switch(
                activeTrackColor: Colors.blue,
                value: scheduleProvider.schedules[widget.scheIdx].status,
                onChanged: (value) {
                  scheduleService.updateSchedule(
                      context, widget.scheIdx, value);
                },
              )
            ],
          ),
          Text(
              "Brightness: ${scheduleProvider.schedules[widget.scheIdx].value} %",
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

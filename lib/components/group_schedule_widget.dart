import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:led_control_app/providers/group_setting_provider.dart';
import 'package:led_control_app/server/group_setting_service.dart';
import 'package:led_control_app/utils/app_color.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class GroupScheduleWidget extends StatefulWidget {
  int scheIdx;
  GroupScheduleWidget({super.key, required this.scheIdx});

  @override
  State<GroupScheduleWidget> createState() => _GroupScheduleWidgetState();
}

class _GroupScheduleWidgetState extends State<GroupScheduleWidget> {
  late DateTime dateTimeFormat;
  late GroupSettingProvider groupSettingProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupSettingProvider =
        Provider.of<GroupSettingProvider>(context, listen: false);
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
          hh += 12;
          if (hh == 24) hh = 0;
          return DateTime(2024, 1, 1, hh, int.parse(hhmm[1]));
        }
    }
    return DateTime.now();
  }

  GroupSettingService scheduleService = GroupSettingService();
  @override
  Widget build(BuildContext context) {
    var _dateFormat = this
        .covertDateString(groupSettingProvider.schedules[widget.scheIdx].time);
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
                value: groupSettingProvider.schedules[widget.scheIdx].status,
                onChanged: (value) {
                  scheduleService.updateSchedule(
                      context, widget.scheIdx, value);
                  // setState(() {
                  //   widget.item = widget.item.copyWith(status: value);
                  // });
                },
              )
            ],
          ),
          Text(
              "Brightness: ${groupSettingProvider.schedules[widget.scheIdx].value} %",
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

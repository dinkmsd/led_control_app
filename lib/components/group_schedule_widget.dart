import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:led_control_app/models/schedule.dart';
import 'package:led_control_app/server/group_setting_service.dart';
import 'package:led_control_app/utils/app_color.dart';
import 'package:led_control_app/utils/custom_switch.dart';

// ignore: must_be_immutable
class GroupScheduleWidget extends StatefulWidget {
  Schedule item;
  GroupScheduleWidget({super.key, required this.item});

  @override
  State<GroupScheduleWidget> createState() => _GroupScheduleWidgetState();
}

class _GroupScheduleWidgetState extends State<GroupScheduleWidget> {
  late DateTime dateTimeFormat;

  void login() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    var _dateFormat = this.covertDateString(widget.item.time);
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
              CustomSwitch(
                value: widget.item.status,
                onChanged: (value) {
                  scheduleService.updateSchedule(
                      context, widget.item.id, value);
                  setState(() {
                    widget.item = widget.item.copyWith(status: value);
                  });
                },
              ),
            ],
          ),
          Text("Brightness: ${widget.item.value} %",
              style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:led_control_app/models/led_model.dart';
import 'package:led_control_app/providers/user_provider.dart';
import 'package:led_control_app/server/schedule_service.dart';
import 'package:led_control_app/utils/app_color.dart';
import 'package:led_control_app/utils/custom_switch.dart';
import 'package:provider/provider.dart';

class ScheduleWidget extends StatefulWidget {
  final Schedule item;
  const ScheduleWidget({super.key, required this.item});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  late UserProvider userProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  ScheduleService scheduleService = ScheduleService();
  @override
  Widget build(BuildContext context) {
    String hhmm = DateFormat('hh:mm ').format(widget.item.time);
    String aa = DateFormat('aa').format(widget.item.time);
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
              if (userProvider.user.role > 0)
                CustomSwitch(
                  value: widget.item.status,
                  onChanged: (value) {
                    scheduleService.updateSchedule(
                        context, widget.item.id, value);
                    setState(() {
                      widget.item.status = value;
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

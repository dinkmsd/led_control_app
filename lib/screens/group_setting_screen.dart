import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:led_control_app/components/group_schedule_widget.dart';
import 'package:led_control_app/providers/group_setting_provider.dart';
import 'package:led_control_app/server/group_setting_service.dart';
import 'package:led_control_app/utils/custom_textfield.dart';
import 'package:led_control_app/utils/patten.dart';
import 'package:provider/provider.dart';

class GroupSettingScreen extends StatefulWidget {
  final Function(dynamic) onChangeStatus;
  final status;
  GroupSettingScreen(
      {super.key, required this.onChangeStatus, required this.status});

  @override
  State<GroupSettingScreen> createState() => _GroupSettingScreenState();
}

class _GroupSettingScreenState extends State<GroupSettingScreen> {
  GroupSettingService groupSettingService = GroupSettingService();
  late bool currentStatus;
  @override
  void initState() {
    groupSettingService.getSchedule(context);
    currentStatus = widget.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setting")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          groupSettingService.setTimer(
              context, DateFormat('hh:mm aa').format(DateTime.now()));
          final valueController = TextEditingController();
          var scheduleProvider =
              Provider.of<GroupSettingProvider>(context, listen: false);
          showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ChangeNotifierProvider.value(
                  value: scheduleProvider,
                  child: Consumer<GroupSettingProvider>(
                      builder: (context, state, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
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
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel')),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.ios_share)),
                                ],
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Add Schedule',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              TextButton(
                                onPressed: () async {
                                  var selectedTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ) ??
                                      TimeOfDay.now();
                                  var selectedDateTime = DateTime(2024, 1, 1,
                                      selectedTime.hour, selectedTime.minute);

                                  // ignore: use_build_context_synchronously
                                  groupSettingService.setTimer(
                                      context,
                                      DateFormat('hh:mm aa')
                                          .format(selectedDateTime));
                                },
                                child: Text(
                                  groupSettingService.getTimer(context),
                                  style: const TextStyle(fontSize: 32),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: CustomTextField(
                                  controller: valueController,
                                  hintText: 'Enter value',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 3 / 4,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Add schedule handler
                                groupSettingService.setSchedule(
                                    context, valueController.text);
                                Navigator.of(context).pop();
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
                                  backgroundColor: const Color(0xFF007AFF),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<GroupSettingProvider>(builder: (context, state, child) {
        if (state.state == LoadingState.success) {
          var items = state.schedules;
          return Column(
            children: [
              Padding(
                padding: contentPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Group Control Mode',
                      style: TextStyle(fontSize: 18),
                    ),
                    Switch(
                      // This bool value toggles the switch.
                      value: currentStatus,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        widget.onChangeStatus(value);
                        setState(() {
                          currentStatus = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: contentPadding,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Delete this group"),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Dismissible(
                      key: Key(item.id),
                      onDismissed: (direction) {
                        groupSettingService.deleteSchedule(context, item.id);
                        setState(() {
                          items.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$item dismissed')));
                      },
                      background: Container(color: Colors.red),
                      child: GroupScheduleWidget(scheIdx: index),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

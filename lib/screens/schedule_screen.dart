import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:led_control_app/components/schedule_widget.dart';
import 'package:led_control_app/providers/schedule_provider.dart';
import 'package:led_control_app/providers/user_provider.dart';
import 'package:led_control_app/server/schedule_service.dart';
import 'package:led_control_app/utils/custom_textfield.dart';
import 'package:led_control_app/utils/patten.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  final Function(dynamic) onChangeStatus;
  final autoMode;
  const ScheduleScreen(
      {super.key, required this.autoMode, required this.onChangeStatus});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late bool currentAutoMode;

  ScheduleService scheduleService = ScheduleService();
  late UserProvider userProvider;

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    scheduleService.getSchedule(context);
    currentAutoMode = widget.autoMode;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Schedule")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // var pickedTime = DateFormat('hh:mm aa').format(DateTime.now());
          scheduleService.setTimer(
              context, DateFormat('hh:mm aa').format(DateTime.now()));
          final valueController = TextEditingController();
          var scheduleProvider =
              Provider.of<ScheduleProvider>(context, listen: false);
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
                  child: Consumer<ScheduleProvider>(
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
                                  scheduleService.setTimer(
                                      context,
                                      DateFormat('hh:mm aa')
                                          .format(selectedDateTime));
                                },
                                child: Text(
                                  scheduleService.getTimer(context),
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
                          height: 90,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 3 / 4,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Add schedule handler
                                scheduleService.setSchedule(
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
      body: Consumer<ScheduleProvider>(builder: (context, state, child) {
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
                      'Auto Mode',
                      style: TextStyle(fontSize: 18),
                    ),
                    Switch(
                      // This bool value toggles the switch.
                      value: currentAutoMode,
                      activeTrackColor: Colors.green,
                      onChanged: (value) {
                        widget.onChangeStatus(value);
                        setState(() {
                          currentAutoMode = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Dismissible(
                      // Each Dismissible must contain a Key. Keys allow Flutter to
                      // uniquely identify widgets.
                      key: Key(item.id),
                      // Provide a function that tells the app
                      // what to do after an item has been swiped away.
                      onDismissed: (direction) {
                        // Remove the item from the data source
                        scheduleService.deleteSchedule(context, item.id);
                        setState(() {
                          items.removeAt(index);
                        });

                        // Then show a snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$item dismissed')));
                      },
                      // Show a red background as the item is swiped away.
                      background: Container(color: Colors.red),
                      child: ScheduleWidget(scheIdx: index),
                    );
                  },
                  // itemBuilder: (context, index) =>
                  //     scheduleItem(Schedule(time: DateTime(2024), value: 30)),
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
